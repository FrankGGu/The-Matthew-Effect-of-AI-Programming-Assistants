#include <stdlib.h>

int compare(const void *a, const void *b) {
    const int *arr1 = *(const int **)a;
    const int *arr2 = *(const int **)b;

    // Sort primarily by the end coordinate (points[i][1])
    // Using long long for comparison to prevent potential overflow if arr1[1] - arr2[1]
    // were to exceed INT_MAX or fall below INT_MIN for very large/small coordinates,
    // although for typical LeetCode constraints, int difference usually suffices.
    // For direct coordinate comparison, int is fine.
    if (arr1[1] != arr2[1]) {
        return (arr1[1] < arr2[1]) ? -1 : 1;
    }
    // If end coordinates are equal, sort by start coordinate (points[i][0])
    return (arr1[0] < arr2[0]) ? -1 : 1;
}

int findMinArrowShots(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize == 0) {
        return 0;
    }

    // Sort the balloons based on their end coordinates.
    // If end coordinates are equal, sort by start coordinates.
    qsort(points, pointsSize, sizeof(int*), compare);

    int arrows = 1;
    // The end point of the current arrow's range.
    // Initialize with the end point of the first balloon after sorting.
    // Using long long for current_arrow_end to safely handle coordinates up to INT_MAX.
    long long current_arrow_end = points[0][1]; 

    for (int i = 1; i < pointsSize; i++) {
        // If the current balloon's start point is beyond the current arrow's effective end point,
        // it means this balloon cannot be burst by the current arrow.
        // We need a new arrow.
        if (points[i][0] > current_arrow_end) {
            arrows++;
            // The new arrow's effective end point is determined by the end of this new balloon.
            current_arrow_end = points[i][1];
        }
        // If points[i][0] <= current_arrow_end, it means this balloon overlaps with the current arrow's range.
        // No new arrow is needed. The current_arrow_end remains the same because we want to maximize
        // the reach of the current arrow, and by sorting by end points, current_arrow_end already
        // represents the earliest end point among the balloons burst by this arrow, which is the
        // optimal point to shoot to cover as many subsequent balloons as possible.
    }

    return arrows;
}