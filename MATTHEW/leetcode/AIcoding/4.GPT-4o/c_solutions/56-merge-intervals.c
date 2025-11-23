#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int **)a)[0] - (*(int **)b)[0];
}

int** merge(int** intervals, int intervalsSize, int* returnSize, int** returnColumnSizes) {
    if (intervalsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    qsort(intervals, intervalsSize, sizeof(int*), cmp);

    int** merged = (int**)malloc(intervalsSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(intervalsSize * sizeof(int));
    int index = 0;

    merged[index] = (int*)malloc(2 * sizeof(int));
    merged[index][0] = intervals[0][0];
    merged[index][1] = intervals[0][1];

    for (int i = 1; i < intervalsSize; i++) {
        if (intervals[i][0] <= merged[index][1]) {
            merged[index][1] = merged[index][1] > intervals[i][1] ? merged[index][1] : intervals[i][1];
        } else {
            index++;
            merged[index] = (int*)malloc(2 * sizeof(int));
            merged[index][0] = intervals[i][0];
            merged[index][1] = intervals[i][1];
        }
    }

    *returnSize = index + 1;
    for (int i = 0; i <= index; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    return merged;
}