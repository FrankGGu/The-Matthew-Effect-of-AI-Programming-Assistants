#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDeletionSize(char** strs, int strsSize) {
    int len = strlen(strs[0]);
    int count = 0;
    for (int j = 0; j < len; j++) {
        for (int i = 1; i < strsSize; i++) {
            if (strs[i][j] < strs[i - 1][j]) {
                count++;
                goto next_column;
            }
        }
        next_column:;
    }
    return count;
}