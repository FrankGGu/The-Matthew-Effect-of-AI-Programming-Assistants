#include <stdio.h>
#include <stdlib.h>

typedef struct Interval {
    int start;
    int end;
} Interval;

int compare(const void *a, const void *b) {
    Interval *x = (Interval *)a;
    Interval *y = (Interval *)b;
    return x->start - y->start;
}

int** merge(int** intervals, int intervalsSize, int* returnSize, int** returnColumnSizes) {
    if (intervalsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    qsort(intervals, intervalsSize, sizeof(Interval), compare);

    int **result = (int **)malloc(intervalsSize * sizeof(int *));
    *returnColumnSizes = (int *)malloc(intervalsSize * sizeof(int));
    int count = 0;

    int start = intervals[0]->start;
    int end = intervals[0]->end;

    for (int i = 1; i < intervalsSize; i++) {
        if (intervals[i]->start <= end) {
            end = (end > intervals[i]->end) ? end : intervals[i]->end;
        } else {
            result[count] = (int *)malloc(2 * sizeof(int));
            result[count][0] = start;
            result[count][1] = end;
            (*returnColumnSizes)[count++] = 2;
            start = intervals[i]->start;
            end = intervals[i]->end;
        }
    }

    result[count] = (int *)malloc(2 * sizeof(int));
    result[count][0] = start;
    result[count][1] = end;
    (*returnColumnSizes)[count++] = 2;

    *returnSize = count;
    return result;
}