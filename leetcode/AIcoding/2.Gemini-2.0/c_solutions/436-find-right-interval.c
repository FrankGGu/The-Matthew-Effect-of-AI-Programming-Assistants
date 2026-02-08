#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findRightInterval(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize) {
    *returnSize = intervalsSize;
    int* result = (int*)malloc(intervalsSize * sizeof(int));
    if (result == NULL) {
        return NULL;
    }

    for (int i = 0; i < intervalsSize; i++) {
        result[i] = -1;
        int min_start = INT_MAX;
        int min_index = -1;
        for (int j = 0; j < intervalsSize; j++) {
            if (intervals[j][0] >= intervals[i][1]) {
                if (intervals[j][0] < min_start) {
                    min_start = intervals[j][0];
                    min_index = j;
                }
            }
        }
        result[i] = min_index;
    }

    return result;
}