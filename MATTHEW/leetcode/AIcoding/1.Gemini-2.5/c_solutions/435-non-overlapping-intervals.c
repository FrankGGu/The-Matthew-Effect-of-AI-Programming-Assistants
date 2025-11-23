#include <stdlib.h>

int compareIntervals(const void *a, const void *b) {
    const int *intervalA = *(const int **)a;
    const int *intervalB = *(const int **)b;

    // Sort by end time
    if (intervalA[1] != intervalB[1]) {
        return intervalA[1] - intervalB[1];
    }
    // If end times are equal, sort by start time
    return intervalA[0] - intervalB[0];
}

int eraseOverlapIntervals(int** intervals, int intervalsSize, int* intervalsColSize) {
    if (intervalsSize == 0) {
        return 0;
    }

    // Sort intervals based on their end points
    qsort(intervals, intervalsSize, sizeof(int*), compareIntervals);

    int nonOverlappingCount = 1; // At least one interval can always be picked
    int lastEndTime = intervals[0][1]; // The end time of the first chosen interval

    // Iterate through the sorted intervals starting from the second one
    for (int i = 1; i < intervalsSize; i++) {
        // If the current interval's start time is greater than or equal to the last chosen interval's end time,
        // it means there is no overlap, and we can pick this interval.
        if (intervals[i][0] >= lastEndTime) {
            nonOverlappingCount++;
            lastEndTime = intervals[i][1]; // Update the end time of the last chosen interval
        }
    }

    // The minimum number of intervals to remove is the total number of intervals
    // minus the maximum number of non-overlapping intervals found.
    return intervalsSize - nonOverlappingCount;
}