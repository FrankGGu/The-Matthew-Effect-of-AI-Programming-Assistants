#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Interval {
    int start;
    int end;
};

int compareIntervals(const void *a, const void *b) {
    return ((struct Interval*)a)->start - ((struct Interval*)b)->start;
}

struct Interval* merge(struct Interval* intervals, int intervalsSize, int* returnSize) {
    if (intervalsSize <= 0) {
        *returnSize = 0;
        return NULL;
    }

    qsort(intervals, intervalsSize, sizeof(struct Interval), compareIntervals);

    struct Interval* merged = (struct Interval*)malloc(intervalsSize * sizeof(struct Interval));
    int mergedSize = 0;

    merged[mergedSize++] = intervals[0];

    for (int i = 1; i < intervalsSize; i++) {
        struct Interval current = intervals[i];
        struct Interval lastMerged = merged[mergedSize - 1];

        if (current.start <= lastMerged.end) {
            merged[mergedSize - 1].end = (current.end > lastMerged.end) ? current.end : lastMerged.end;
        } else {
            merged[mergedSize++] = current;
        }
    }

    *returnSize = mergedSize;
    return merged;
}