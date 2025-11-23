var minOperations = function(nums) {
    let n = nums.length;
    let dp = new Array(n).fill(Infinity);
    dp[0] = nums[0] === 0 ? 0 : 1;

    for (let i = 1; i < n; i++) {
        if (nums[i] === 0) {
            dp[i] = dp[i - 1];
        } else {
            dp[i] = dp[i - 1] + 1;
            let j = i - 1;
            while (j >= 0 && nums[j] === nums[i]) {
                j--;
            }
            if (j >= 0) {
                dp[i] = Math.min(dp[i], dp[j] + 1);
            } else {
                dp[i] = Math.min(dp[i], 1);
            }
        }
    }

    return dp[n - 1];
};