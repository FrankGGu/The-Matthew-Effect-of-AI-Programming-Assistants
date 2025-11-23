#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDeletionSize(char** strs, int strsSize) {
    int n = strlen(strs[0]);
    int m = strsSize;
    int count = 0;

    for (int j = 0; j < n; j++) {
        for (int i = 0; i < m - 1; i++) {
            if (strs[i][j] > strs[i + 1][j]) {
                count++;
                break;
            }
        }
    }

    return count;
}