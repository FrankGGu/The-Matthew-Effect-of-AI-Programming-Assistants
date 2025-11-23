#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return strlen(*(char**)b) - strlen(*(char**)a);
}

int isSubsequence(char *s, char *t) {
    int i = 0, j = 0;
    while (s[i] && t[j]) {
        if (s[i] == t[j]) i++;
        j++;
    }
    return s[i] == '\0';
}

int findLUSlength(char ** strs, int strsSize) {
    qsort(strs, strsSize, sizeof(char*), compare);
    for (int i = 0; i < strsSize; i++) {
        int flag = 1;
        for (int j = 0; j < strsSize; j++) {
            if (i != j && isSubsequence(strs[i], strs[j])) {
                flag = 0;
                break;
            }
        }
        if (flag) return strlen(strs[i]);
    }
    return -1;
}