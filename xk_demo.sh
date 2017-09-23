#########################################################################
# File Name: xk_*.sh
# Author: ke.xiao
# mail: ke.xiao@netxeon.com
# Created Time: Sun 27 Nov 2016 10:22:30 PM EST
#########################################################################
#!/bin/bash

#############################################################################
mTOP_DIR=`pwd`
xkTools_DIR="$(cd "$(dirname "$0")" && pwd)"
export xkTools_DIR=${xkTools_DIR}
source ${xkTools_DIR}/xk_function.sh

config_get XKTOOLS_VERSION
config_show

TOP_DIR=${mTOP_DIR}
ERR=0
VERBOSE=
NCPU=`grep processor /proc/cpuinfo | wc -l`
MAKE_THREAD=`expr $NCPU - 0`
DATE=$(date  +%Y%m%d.%H%M)

#set umask here to prevent incorrect file permission
umask 0022
#############################################################################

#config show
config_show()
{
	pushd ${TOP_DIR} > /dev/null
	fun_cmd cat ${xkTools_DIR}/.build_config
	popd > /dev/null
	echo -e "\033[32m[#########################^_^#########################]\033[0m"
}

if [ "$1" = "" ]
then
	echo "$0 commands are:"
	echo "    config_show "
else
	while [ "$1" != "" ]
	do
		case "$1" in
			config_show)
				config_show
				;;
			*)
				echo -e "$0 \033[47;31mUnknown CMD: $1\033[0m"
				exit 1
				;;
		esac
		shift 1
	done
fi
