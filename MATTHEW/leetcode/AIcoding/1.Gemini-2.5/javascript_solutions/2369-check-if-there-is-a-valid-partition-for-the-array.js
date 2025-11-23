var validPartition = function(nums) {
    const n = nums.length;
    const dp = new Array(n + 1).fill(false);

    dp[0] = true;

    for (let i = 1; i <= n; i++) {
        // Check for a 2-element valid partition ending at index i-1
        if (i >= 2) {
            if (nums[i - 1] === nums[i - 2]) {
                if (dp[i - 2]) {
                    dp[i] = true;
                }
            }
        }

        // Check for a 3-element valid partition ending at index i-1
        if (i >= 3) {
            if (dp[i - 3]) {
                // Type 2: three equal elements
                if (nums[i - 1] === nums[i - 2] && nums[i - 2] === nums[i - 3]) {
                    dp[i] = true;
                }
                // Type 3: three consecutive increasing elements
                if (nums[i - 1] === nums[i - 2] + 1 && nums[i - 2] === nums[i - 3] + 1) {
                    dp[i] = true;
                }
            }
        }
    }

    return dp[n];
};