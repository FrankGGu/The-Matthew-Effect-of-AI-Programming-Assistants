#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    return x[1] - y[1];
}

int maxScore(int** intervals, int intervalsSize, int* intervalsColSize) {
    qsort(intervals, intervalsSize, sizeof(int*), compare);

    int score = 0;
    int lastEnd = -1;

    for (int i = 0; i < intervalsSize; i++) {
        if (intervals[i][0] >= lastEnd) {
            score += intervals[i][1] - intervals[i][0] + 1;
            lastEnd = intervals[i][1];
        }
    }

    return score;
}