#include <stdlib.h> // For qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int getMaxConsecutive(int* bars, int barsSize) {
    if (barsSize == 0) {
        return 0; // If no bars are removed, there are 0 consecutive removed bars
    }

    // Sort the bars to easily find consecutive sequences
    qsort(bars, barsSize, sizeof(int), compare);

    int max_consecutive_found = 1;
    int current_consecutive = 1;

    for (int i = 1; i < barsSize; i++) {
        if (bars[i] == bars[i-1] + 1) {
            current_consecutive++;
        } else {
            current_consecutive = 1;
        }
        // Update max_consecutive_found if current sequence is longer
        if (current_consecutive > max_consecutive_found) {
            max_consecutive_found = current_consecutive;
        }
    }
    return max_consecutive_found;
}

int maximizeSquareHoleArea(int n, int m, int* hBars, int hBarsSize, int* vBars, int vBarsSize) {
    // Calculate the maximum number of consecutive removed horizontal bars
    int max_h_consecutive = getMaxConsecutive(hBars, hBarsSize);

    // Calculate the maximum number of consecutive removed vertical bars
    int max_v_consecutive = getMaxConsecutive(vBars, vBarsSize);

    // The side length of the square hole is (number of consecutive bars + 1).
    // For example, if 1 bar is removed, it connects 2 cells, forming a side of 2.
    // If 0 bars are removed, it connects 1 cell, forming a side of 1.
    int side_h = max_h_consecutive + 1;
    int side_v = max_v_consecutive + 1;

    // The maximum side length of the square hole is limited by the minimum of the two dimensions
    int min_side = (side_h < side_v) ? side_h : side_v;

    // The area of the square hole is side * side
    // Using long long for intermediate calculation to prevent overflow before casting to int,
    // as the problem specifies an int return type.
    long long area = (long long)min_side * min_side;

    return (int)area;
}