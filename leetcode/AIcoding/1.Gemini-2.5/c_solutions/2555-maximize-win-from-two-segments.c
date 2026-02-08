#include <stdlib.h> // For qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int int_max(int a, int b) {
    return (a > b ? a : b);
}

int maximizeWin(int* prizes, int prizesSize, int k) {
    if (prizesSize == 0) {
        return 0;
    }

    // 1. Sort the prizes array to enable efficient sliding window
    qsort(prizes, prizesSize, sizeof(int), compare);

    // 2. Find the maximum number of prizes that can be collected in any single segment of length k.
    // This is done using a two-pointer (sliding window) approach.
    int max_single_segment_win = 0;
    int left = 0;
    for (int right = 0; right < prizesSize; ++right) {
        // The current window of prizes is from prizes[left] to prizes[right].
        // We want to find a segment of length k that covers all prizes in this window.
        // The segment [prizes[right] - k + 1, prizes[right]] is the rightmost possible segment
        // of length k that ends at prizes[right].
        // We need to ensure that prizes[left] falls within this segment, i.e.,
        // prizes[left] >= prizes[right] - k + 1.
        // If prizes[left] is too far to the left (i.e., prizes[right] - prizes[left] > k - 1),
        // we shrink the window from the left by incrementing 'left'.
        while (prizes[right] - prizes[left] > k - 1) {
            left++;
        }

        // At this point, all prizes from prizes[left] to prizes[right] are contained within
        // a segment of length k (specifically, [prizes[right] - k + 1, prizes[right]]).
        // The number of prizes in this valid window is (right - left + 1).
        max_single_segment_win = int_max(max_single_segment_win, right - left + 1);
    }

    // 3. The problem asks to maximize the total number of prizes from "up to two segments".
    // The segments can overlap. The example output suggests that the total count is the sum of
    // prizes in the first segment and prizes in the second segment, not the count of their union.
    //
    // If we want to maximize (count in Segment1) + (count in Segment2), and the segments can be
    // chosen arbitrarily (even identically and overlapping), the optimal strategy is to pick
    // the single best segment (the one that yields 'max_single_segment_win' prizes) twice.
    // This will give a total of 'max_single_segment_win + max_single_segment_win' prizes.
    // Any other combination of two segments S1 and S2 would yield count(S1) + count(S2) <=
    // max_single_segment_win + max_single_segment_win, since count(S1) <= max_single_segment_win
    // and count(S2) <= max_single_segment_win.
    return 2 * max_single_segment_win;
}