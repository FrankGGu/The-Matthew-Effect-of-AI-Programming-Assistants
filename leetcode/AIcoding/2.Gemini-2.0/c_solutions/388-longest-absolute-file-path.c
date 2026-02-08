#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int lengthLongestPath(char * input) {
    int maxLen = 0;
    int pathLen[201] = {0};
    int level = 0;
    int len = 0;
    int isFile = 0;
    char *p = input;
    while (*p) {
        level = 0;
        while (*p == '\t') {
            level++;
            p++;
        }
        len = 0;
        isFile = 0;
        while (*p != '\n' && *p != '\0') {
            if (*p == '.') {
                isFile = 1;
            }
            len++;
            p++;
        }
        if (*p == '\n') {
            p++;
        }
        int currentPathLen = (level > 0 ? pathLen[level - 1] + len + 1 : len);
        pathLen[level] = currentPathLen;
        if (isFile) {
            maxLen = (currentPathLen > maxLen) ? currentPathLen : maxLen;
        }
    }
    return maxLen;
}