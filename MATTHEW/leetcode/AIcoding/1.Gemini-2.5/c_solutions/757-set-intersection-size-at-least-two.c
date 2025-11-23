#include <stdlib.h> // Required for qsort

int compareIntervals(const void* a, const void* b) {
    const int* intervalA = *(const int**)a;
    const int* intervalB = *(const int**)b;

    if (intervalA[1] != intervalB[1]) {
        return intervalA[1] - intervalB[1]; // Sort by end point ascending
    } else {
        return intervalB[0] - intervalA[0]; // Sort by start point descending
    }
}

int intersectionSizeTwo(int** intervals, int intervalsSize, int* intervalsColSize) {
    if (intervalsSize == 0) {
        return 0;
    }

    qsort(intervals, intervalsSize, sizeof(int*), compareIntervals);

    int ans = 0;
    // p1 and p2 represent the two largest points in our set S that
    // have been added so far. p1 is always the largest, p2 the second largest (p1 > p2).
    // Initialize them to -1 to indicate no points have been added yet,
    // assuming interval coordinates are non-negative.
    int p1 = -1; 
    int p2 = -1; 

    for (int i = 0; i < intervalsSize; ++i) {
        int start = intervals[i][0];
        int end = intervals[i][1];

        // Case 1: The current interval [start, end] is not covered by p1 or p2 at all.
        // This means start is greater than both p1 and p2.
        if (start > p1) {
            // We need to add two new points. To maximize their utility for future intervals,
            // we choose the largest possible points within the current interval: end-1 and end.
            ans += 2;
            p1 = end;
            p2 = end - 1;
        } 
        // Case 2: The current interval [start, end] is covered by p1, but not by p2.
        // This means start <= p1, but start > p2.
        else if (start > p2) {
            // We need to add one new point. The current p1 is already in [start, end].
            // To maximize utility, we add 'end' as the new largest point.
            // The old p1 becomes the new p2.
            ans += 1;
            p2 = p1; // The old largest point becomes the second largest
            p1 = end; // The new point 'end' becomes the largest
        }
        // Case 3: The current interval [start, end] is covered by both p1 and p2.
        // This means start <= p2 (and thus start <= p1 as well).
        // No new points are needed for this interval.
    }

    return ans;
}