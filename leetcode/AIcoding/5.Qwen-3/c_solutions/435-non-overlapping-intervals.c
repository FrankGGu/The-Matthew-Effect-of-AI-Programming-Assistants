#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int end;
} Interval;

int compare(const void *a, const void *b) {
    Interval *intervalA = (Interval *)a;
    Interval *intervalB = (Interval *)b;
    return intervalA->end - intervalB->end;
}

int eraseOverlapIntervals(Interval* intervals, int intervalsSize) {
    if (intervalsSize == 0) return 0;
    qsort(intervals, intervalsSize, sizeof(Interval), compare);
    int count = 1;
    int lastEnd = intervals[0].end;
    for (int i = 1; i < intervalsSize; i++) {
        if (intervals[i].start >= lastEnd) {
            count++;
            lastEnd = intervals[i].end;
        }
    }
    return intervalsSize - count;
}