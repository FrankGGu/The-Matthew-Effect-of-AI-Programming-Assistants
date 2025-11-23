#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int **)a)[0] - (*(int **)b)[0];
}

int** merge(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize, int** returnColumnSizes) {
    if (intervalsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    qsort(intervals, intervalsSize, sizeof(int*), cmp);

    int** merged = (int**)malloc(sizeof(int*) * intervalsSize);
    *returnColumnSizes = (int*)malloc(sizeof(int) * intervalsSize);
    int count = 0;

    merged[count] = (int*)malloc(sizeof(int) * 2);
    merged[count][0] = intervals[0][0];
    merged[count][1] = intervals[0][1];
    count++;

    for (int i = 1; i < intervalsSize; i++) {
        if (intervals[i][0] <= merged[count - 1][1]) {
            merged[count - 1][1] = merged[count - 1][1] > intervals[i][1] ? merged[count - 1][1] : intervals[i][1];
        } else {
            merged[count] = (int*)malloc(sizeof(int) * 2);
            merged[count][0] = intervals[i][0];
            merged[count][1] = intervals[i][1];
            count++;
        }
    }

    *returnSize = count;
    *returnColumnSizes = (int*)malloc(sizeof(int) * count);
    for (int i = 0; i < count; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    return merged;
}