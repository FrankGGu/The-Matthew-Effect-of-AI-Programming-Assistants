int max(int a, int b) {
    return a > b ? a : b;
}

int maxSubsequenceSum(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }
    if (numsSize == 1) {
        return max(0, nums[0]);
    }

    int prev2 = 0; // Represents dp[i-2], max sum up to index i-2
    int prev1 = max(0, nums[0]); // Represents dp[i-1], max sum up to index i-1

    for (int i = 1; i < numsSize; i++) {
        int current_val = nums[i];

        // Option 1: Don't include current_val (nums[i])
        // The maximum sum is the same as the maximum sum up to the previous element (dp[i-1]), which is prev1.

        // Option 2: Include current_val (nums[i])
        // If we include nums[i], we cannot include nums[i-1].
        // So, we add nums[i] to the maximum sum up to nums[i-2] (dp[i-2]), which is prev2.

        int current_max = max(prev1, current_val + prev2);

        // Update prev2 and prev1 for the next iteration
        prev2 = prev1;
        prev1 = current_max;
    }

    return prev1;
}