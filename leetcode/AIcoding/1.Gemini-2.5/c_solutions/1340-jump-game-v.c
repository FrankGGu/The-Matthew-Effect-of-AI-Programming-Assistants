#include <stdlib.h>
#include <string.h>

static int max(int a, int b) {
    return a > b ? a : b;
}

static int* arr_ptr;
static int n_val;
static int d_val;
static int* dp_memo; // Memoization table

static int dfs(int i) {
    // If the result for index i is already computed, return it
    if (dp_memo[i] != 0) {
        return dp_memo[i];
    }

    // Initialize the maximum jumps from current index i to 1 (for the index itself)
    int current_max_jumps = 1;

    // Explore jumps to the right
    // Iterate from i + 1 up to min(i + d_val, n_val - 1)
    for (int j = i + 1; j <= i + d_val && j < n_val; ++j) {
        // If arr[j] is greater than or equal to arr[i], we cannot jump to j
        // and cannot jump past j in this direction, so break.
        if (arr_ptr[j] >= arr_ptr[i]) {
            break;
        }
        // If arr[j] < arr[i], it's a valid jump. Recursively find max jumps from j.
        current_max_jumps = max(current_max_jumps, 1 + dfs(j));
    }

    // Explore jumps to the left
    // Iterate from i - 1 down to max(i - d_val, 0)
    for (int j = i - 1; j >= i - d_val && j >= 0; --j) {
        // If arr[j] is greater than or equal to arr[i], we cannot jump to j
        // and cannot jump past j in this direction, so break.
        if (arr_ptr[j] >= arr_ptr[i]) {
            break;
        }
        // If arr[j] < arr[i], it's a valid jump. Recursively find max jumps from j.
        current_max_jumps = max(current_max_jumps, 1 + dfs(j));
    }

    // Store the computed result in the memoization table
    dp_memo[i] = current_max_jumps;
    return current_max_jumps;
}

int maxJumps(int* arr, int arrSize, int d) {
    // Assign input parameters to global variables
    arr_ptr = arr;
    n_val = arrSize;
    d_val = d;

    // Allocate memory for the memoization table
    dp_memo = (int*)malloc(sizeof(int) * arrSize);
    if (dp_memo == NULL) {
        // Handle allocation failure if necessary, though LeetCode environment usually guarantees success
        return 0; 
    }
    // Initialize dp_memo with 0s. 0 indicates an uncomputed state.
    memset(dp_memo, 0, sizeof(int) * arrSize);

    int overall_max_jumps = 0;
    // Iterate through all possible starting points
    for (int i = 0; i < arrSize; ++i) {
        overall_max_jumps = max(overall_max_jumps, dfs(i));
    }

    // Free the allocated memory
    free(dp_memo);

    return overall_max_jumps;
}