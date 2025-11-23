#include <stdio.h>
#include <stdlib.h>

typedef struct Interval {
    int start;
    int end;
} Interval;

int** merge(int** intervals, int intervalsSize, int* returnSize, int** returnColumns) {
    if (intervalsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    // Sort intervals based on start time
    for (int i = 0; i < intervalsSize - 1; i++) {
        for (int j = 0; j < intervalsSize - i - 1; j++) {
            if (intervals[j][0] > intervals[j + 1][0]) {
                int temp = intervals[j][0];
                intervals[j][0] = intervals[j + 1][0];
                intervals[j + 1][0] = temp;
                temp = intervals[j][1];
                intervals[j][1] = intervals[j + 1][1];
                intervals[j + 1][1] = temp;
            }
        }
    }

    int** result = (int**)malloc(intervalsSize * sizeof(int*));
    *returnColumns = (int*)malloc(intervalsSize * sizeof(int));
    *returnSize = 0;

    result[*returnSize] = (int*)malloc(2 * sizeof(int));
    result[*returnSize][0] = intervals[0][0];
    result[*returnSize][1] = intervals[0][1];
    (*returnColumns)[*returnSize] = 2;
    (*returnSize)++;

    for (int i = 1; i < intervalsSize; i++) {
        int* last = result[*returnSize - 1];
        if (intervals[i][0] <= last[1]) {
            // Overlapping intervals, merge them
            if (intervals[i][1] > last[1]) {
                last[1] = intervals[i][1];
            }
        } else {
            // No overlap, add new interval
            result[*returnSize] = (int*)malloc(2 * sizeof(int));
            result[*returnSize][0] = intervals[i][0];
            result[*returnSize][1] = intervals[i][1];
            (*returnColumns)[*returnSize] = 2;
            (*returnSize)++;
        }
    }

    return result;
}