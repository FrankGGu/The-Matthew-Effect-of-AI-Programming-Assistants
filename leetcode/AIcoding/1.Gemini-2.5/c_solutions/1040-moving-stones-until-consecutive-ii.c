#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* numMovesStonesII(int* stones, int stonesSize, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(sizeof(int) * 2);
    if (result == NULL) {
        return NULL; // Handle allocation failure
    }

    qsort(stones, stonesSize, sizeof(int), compare);

    int n = stonesSize;

    // Calculate maximum moves
    // The maximum number of moves is (stones[n-1] - stones[0] + 1 - n)
    // minus the minimum of the two "outer" gaps that cannot be filled.
    // The two outer gaps are (stones[1] - stones[0] - 1) and (stones[n-1] - stones[n-2] - 1).
    int gap1 = stones[1] - stones[0] - 1;
    int gap2 = stones[n-1] - stones[n-2] - 1;
    int min_outer_gap = (gap1 < gap2) ? gap1 : gap2;

    int max_moves_val = (stones[n-1] - stones[0] + 1 - n) - min_outer_gap;
    result[1] = max_moves_val;

    // Calculate minimum moves
    int min_moves_val = n; // Initialize with maximum possible moves (move all but one)
    int left = 0;
    for (int right = 0; right < n; ++right) {
        while (stones[right] - stones[left] + 1 > n) {
            left++;
        }
        int stones_in_window = right - left + 1;

        // Special case: If n-1 stones are in a window of size n, and the empty slot is in the middle.
        // E.g., [1,2,4,5] (n=4). The window [2,4,5] (stones[1],stones[2],stones[3]) spans length 4 (5-2+1).
        // It has 3 stones (n-1). The empty slot is at 3.
        // In this specific scenario, it takes 2 moves.
        // The general formula `n - stones_in_window` would yield 1.
        if (stones_in_window == n - 1 && stones[right] - stones[left] + 1 == n) {
            min_moves_val = (min_moves_val < 2) ? min_moves_val : 2;
        } else {
            min_moves_val = (min_moves_val < (n - stones_in_window)) ? min_moves_val : (n - stones_in_window);
        }
    }
    result[0] = min_moves_val;

    return result;
}