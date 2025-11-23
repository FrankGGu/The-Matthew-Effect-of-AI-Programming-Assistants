#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * longestCommonPrefix(char ** strs, int strsSize){
    if (strsSize == 0) {
        return "";
    }

    if (strsSize == 1) {
        return strs[0];
    }

    int len = strlen(strs[0]);
    for (int i = 1; i < strsSize; i++) {
        int currentLen = strlen(strs[i]);
        if (currentLen < len) {
            len = currentLen;
        }
    }

    int prefixLen = 0;
    for (int i = 0; i < len; i++) {
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

    char *result = (char *)malloc((prefixLen + 1) * sizeof(char));
    if (result == NULL) return NULL;

    strncpy(result, strs[0], prefixLen);
    result[prefixLen] = '\0';

    return result;
}