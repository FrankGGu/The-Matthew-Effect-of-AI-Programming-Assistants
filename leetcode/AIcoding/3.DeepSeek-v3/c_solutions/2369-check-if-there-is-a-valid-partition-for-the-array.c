bool validPartition(int* nums, int numsSize) {
    if (numsSize == 1) return false;

    bool dp[3] = {true, false, nums[0] == nums[1]};

    for (int i = 2; i < numsSize; i++) {
        bool current = false;

        if (nums[i] == nums[i-1] && dp[1]) {
            current = true;
        }
        else if (nums[i] == nums[i-1] && nums[i] == nums[i-2] && dp[0]) {
            current = true;
        }
        else if (nums[i] - nums[i-1] == 1 && nums[i-1] - nums[i-2] == 1 && dp[0]) {
            current = true;
        }

        dp[0] = dp[1];
        dp[1] = dp[2];
        dp[2] = current;
    }

    return dp[2];
}