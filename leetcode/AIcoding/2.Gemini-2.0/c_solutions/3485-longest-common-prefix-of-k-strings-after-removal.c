#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestCommonPrefix(char **strs, int strsSize, int k) {
    if (strsSize == 0) return 0;
    int len = strlen(strs[0]);
    for (int i = 0; i < len; i++) {
        int count = 0;
        for (int j = 1; j < strsSize; j++) {
            if (i < strlen(strs[j]) && strs[j][i] == strs[0][i]) {
                count++;
            }
        }
        if (count < strsSize - 1 - k) {
            return i;
        }
    }
    return len;
}