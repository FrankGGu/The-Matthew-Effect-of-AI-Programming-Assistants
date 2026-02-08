#include <string.h> // For memset

static int memo[501][501];
static int* global_nums;
static int global_target_score;

static int max(int a, int b) {
    return a > b ? a : b;
}

static int solve(int i, int j) {
    // Base case: If the subarray is empty or has only one element, no more operations can be performed.
    if (i >= j) {
        return 0;
    }
    // If already computed, return the memoized value
    if (memo[i][j] != -1) {
        return memo[i][j];
    }

    int res = 0;

    // Option 1: Take nums[i] and nums[i+1]
    // Check if there are at least two elements left and their sum matches the target score
    if (i + 1 <= j && global_nums[i] + global_nums[i+1] == global_target_score) {
        res = max(res, 1 + solve(i+2, j));
    }

    // Option 2: Take nums[j-1] and nums[j]
    // Check if there are at least two elements left and their sum matches the target score
    if (j - 1 >= i && global_nums[j-1] + global_nums[j] == global_target_score) {
        res = max(res, 1 + solve(i, j-2));
    }

    // Option 3: Take nums[i] and nums[j]
    // Check if their sum matches the target score
    if (global_nums[i] + global_nums[j] == global_target_score) {
        res = max(res, 1 + solve(i+1, j-1));
    }

    // Memoize and return the result
    return memo[i][j] = res;
}

int maxOperations(int* nums, int numsSize) {
    global_nums = nums; // Set global_nums pointer

    int n = numsSize;

    // According to constraints, n is always even and >= 2.
    // If n == 2, the logic below handles it correctly, returning 1.

    int ans = 0;

    // Case 1: First operation uses nums[0] and nums[1]
    global_target_score = nums[0] + nums[1];
    memset(memo, -1, sizeof(memo)); // Reset memo table for new target score
    ans = max(ans, 1 + solve(2, n - 1));

    // Case 2: First operation uses nums[n-2] and nums[n-1]
    global_target_score = nums[n-2] + nums[n-1];
    memset(memo, -1, sizeof(memo)); // Reset memo table
    ans = max(ans, 1 + solve(0, n - 3));

    // Case 3: First operation uses nums[0] and nums[n-1]
    global_target_score = nums[0] + nums[n-1];
    memset(memo, -1, sizeof(memo)); // Reset memo table
    ans = max(ans, 1 + solve(1, n - 2));

    return ans;
}