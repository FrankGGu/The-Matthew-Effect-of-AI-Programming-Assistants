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

struct Interval* insert(struct Interval* intervals, int intervalsSize, struct Interval newInterval, int* returnSize) {
    struct Interval* result = (struct Interval*)malloc(sizeof(struct Interval) * (intervalsSize + 1));
    int i = 0, j = 0;

    while (i < intervalsSize && intervals[i].end < newInterval.start) {
        result[j++] = intervals[i++];
    }

    while (i < intervalsSize && intervals[i].start <= newInterval.end) {
        newInterval.start = (newInterval.start < intervals[i].start) ? newInterval.start : intervals[i].start;
        newInterval.end = (newInterval.end > intervals[i].end) ? newInterval.end : intervals[i].end;
        i++;
    }

    result[j++] = newInterval;

    while (i < intervalsSize) {
        result[j++] = intervals[i++];
    }

    *returnSize = j;
    return result;
}