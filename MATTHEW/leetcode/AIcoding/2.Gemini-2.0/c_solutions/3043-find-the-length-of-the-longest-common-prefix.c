#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestCommonPrefix(char ** strs, int strsSize){
    if (strsSize == 0) {
        return 0;
    }

    if (strsSize == 1) {
        return strlen(strs[0]);
    }

    int minLen = strlen(strs[0]);
    for (int i = 1; i < strsSize; i++) {
        int len = strlen(strs[i]);
        if (len < minLen) {
            minLen = len;
        }
    }

    if (minLen == 0) {
        return 0;
    }

    int prefixLen = 0;
    for (int i = 0; i < minLen; i++) {
        char currentChar = strs[0][i];
        int match = 1;
        for (int j = 1; j < strsSize; j++) {
            if (strs[j][i] != currentChar) {
                match = 0;
                break;
            }
        }
        if (match) {
            prefixLen++;
        } else {
            break;
        }
    }

    return prefixLen;
}