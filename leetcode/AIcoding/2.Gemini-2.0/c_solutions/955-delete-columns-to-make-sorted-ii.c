#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDeletionSize(char ** strs, int strsSize){
    int len = strlen(strs[0]);
    int count = 0;
    int *sorted = (int *)malloc(strsSize * sizeof(int));
    for (int i = 0; i < strsSize; i++) {
        sorted[i] = 0;
    }

    for (int j = 0; j < len; j++) {
        int need_delete = 0;
        for (int i = 1; i < strsSize; i++) {
            if (sorted[i] == 0 && strs[i - 1][j] > strs[i][j]) {
                need_delete = 1;
                break;
            }
        }

        if (need_delete) {
            count++;
        } else {
            for (int i = 1; i < strsSize; i++) {
                if (strs[i - 1][j] < strs[i][j]) {
                    sorted[i] = 0;
                } else if (strs[i - 1][j] == strs[i][j]) {

                } else {
                    sorted[i] = 0;
                }
            }
        }
    }

    free(sorted);
    return count;
}