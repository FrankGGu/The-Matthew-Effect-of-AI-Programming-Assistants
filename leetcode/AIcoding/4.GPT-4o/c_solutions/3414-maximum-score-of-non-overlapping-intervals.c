#include <stdio.h>
#include <stdlib.h>

struct Interval {
    int start;
    int end;
    int score;
};

int cmp(const void *a, const void *b) {
    return ((struct Interval *)b)->score - ((struct Interval *)a)->score;
}

int maxScore(int** intervals, int intervalsSize, int* intervalsColSize) {
    struct Interval* arr = malloc(sizeof(struct Interval) * intervalsSize);
    for (int i = 0; i < intervalsSize; i++) {
        arr[i].start = intervals[i][0];
        arr[i].end = intervals[i][1];
        arr[i].score = intervals[i][2];
    }

    qsort(arr, intervalsSize, sizeof(struct Interval), cmp);

    int maxScore = 0, endTime = -1;

    for (int i = 0; i < intervalsSize; i++) {
        if (arr[i].start > endTime) {
            maxScore += arr[i].score;
            endTime = arr[i].end;
        }
    }

    free(arr);
    return maxScore;
}