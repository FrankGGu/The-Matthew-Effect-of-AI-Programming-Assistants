#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
} Interval;

int compareIntervals(const void *a, const void *b) {
    return ((Interval *)a)->start - ((Interval *)b)->start;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int maxFreeTime(Interval* meetings, int meetingsSize) {
    qsort(meetings, meetingsSize, sizeof(Interval), compareIntervals);

    int maxFree = 0;
    int lastEnd = meetings[0].end;

    for (int i = 1; i < meetingsSize; i++) {
        if (meetings[i].start > lastEnd) {
            maxFree = max(maxFree, meetings[i].start - lastEnd);
        }
        lastEnd = max(lastEnd, meetings[i].end);
    }

    return maxFree;
}