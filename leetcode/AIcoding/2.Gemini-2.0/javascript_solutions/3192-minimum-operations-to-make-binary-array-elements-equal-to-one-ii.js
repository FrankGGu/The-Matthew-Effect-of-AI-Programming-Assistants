var minOperations = function(nums) {
    let n = nums.length;
    let dp = Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < n; i++) {
        if (nums[i] === 1) {
            dp[i + 1] = Math.min(dp[i + 1], dp[i]);
        } else {
            dp[i + 1] = Math.min(dp[i + 1], dp[i] + 1);
        }

        if (i + 2 <= n) {
            let nextTwo = [nums[i], nums[i + 1]];
            let ops = 0;
            if (nums[i] === 0) ops++;
            if (nums[i + 1] === 0) ops++;

            dp[i + 2] = Math.min(dp[i + 2], dp[i] + ops);
        }
    }

    return dp[n];
};