#include <stdlib.h> // For calloc, free
#include <string.h> // For memset (though calloc handles initialization)

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int minMoves(int* nums, int numsSize, int limit) {
    // The possible sums range from 2 (1+1) to 2*limit (limit+limit).
    // The diff array will store changes in the number of moves for each sum.
    // We need indices up to 2*limit + 1. So, size 2*limit + 2.
    int diff_size = 2 * limit + 2;
    int* diff = (int*)calloc(diff_size, sizeof(int)); // calloc initializes all elements to 0

    int num_pairs = numsSize / 2;

    for (int i = 0; i < num_pairs; ++i) {
        int a = nums[i];
        int b = nums[numsSize - 1 - i];

        // Ensure a <= b for consistent logic
        if (a > b) {
            int temp = a;
            a = b;
            b = temp;
        }

        // For any target sum S, each pair initially contributes 2 moves.
        // We use the diff array to subtract moves based on specific ranges/sums.

        // 1. For sums S in the range [a + 1, b + limit], only 1 move is needed.
        // This saves 1 move compared to the initial 2 moves.
        // So, we decrement the count for sums starting from (a + 1)
        // and increment for sums starting from (b + limit + 1) to end this effect.
        diff[a + 1] -= 1;
        diff[b + limit + 1] += 1;

        // 2. For the specific sum S = (a + b), 0 moves are needed.
        // This saves another 1 move compared to the 1-move scenario (total 2 moves saved from initial).
        // So, we decrement the count for this specific sum (a + b)
        // and increment for sums starting from (a + b + 1) to end this specific effect.
        diff[a + b] -= 1;
        diff[a + b + 1] += 1;
    }

    // Calculate the actual minimum total moves by sweeping through possible sums.
    // The initial cost for any sum S is 2 moves for each pair (total 2 * num_pairs).
    int current_total_moves = 2 * num_pairs;
    int min_total_moves = current_total_moves;

    // Iterate through possible sums S from 2 to 2*limit
    for (int s = 2; s <= 2 * limit; ++s) {
        current_total_moves += diff[s];
        min_total_moves = min(min_total_moves, current_total_moves);
    }

    free(diff); // Free allocated memory

    return min_total_moves;
}