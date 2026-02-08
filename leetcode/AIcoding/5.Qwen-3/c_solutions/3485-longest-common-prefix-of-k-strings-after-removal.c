#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* longestCommonPrefix(char** strs, int strsSize) {
    if (strsSize == 0) return "";
    char* prefix = (char*)malloc(sizeof(char) * (strlen(strs[0]) + 1));
    strcpy(prefix, strs[0]);
    for (int i = 1; i < strsSize; i++) {
        int j = 0;
        while (j < strlen(prefix) && j < strlen(strs[i]) && prefix[j] == strs[i][j]) {
            j++;
        }
        prefix[j] = '\0';
    }
    return prefix;
}