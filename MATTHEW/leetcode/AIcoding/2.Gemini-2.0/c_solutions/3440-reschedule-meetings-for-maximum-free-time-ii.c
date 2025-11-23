#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
} Interval;

int compareIntervals(const void *a, const void *b) {
    return ((Interval*)a)->start - ((Interval*)b)->start;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int solve(int** meetings, int meetingsSize, int* meetingsColSize, int k) {
    int n = meetingsSize;
    Interval intervals[n];
    for (int i = 0; i < n; i++) {
        intervals[i].start = meetings[i][0];
        intervals[i].end = meetings[i][1];
    }

    qsort(intervals, n, sizeof(Interval), compareIntervals);

    int freeTime = 0;
    int endTime = 0;

    for (int i = 0; i < n; i++) {
        freeTime += max(0, intervals[i].start - endTime);
        endTime = max(endTime, intervals[i].end);
    }

    return freeTime;
}

int maxFreeTime(int*** meetings, int meetingsSize, int* meetingsColSize, int k) {
    int totalMeetings = 0;
    for (int i = 0; i < meetingsSize; i++) {
        totalMeetings += meetingsColSize[i];
    }

    int** mergedMeetings = (int**)malloc(totalMeetings * sizeof(int*));
    int mergedColSize[totalMeetings];
    int index = 0;

    for (int i = 0; i < meetingsSize; i++) {
        for (int j = 0; j < meetingsColSize[i]; j++) {
            mergedMeetings[index] = meetings[i][j];
            mergedColSize[index] = 2; 
            index++;
        }
    }

    int result = solve(mergedMeetings, totalMeetings, mergedColSize, k);
    free(mergedMeetings);
    return result;
}