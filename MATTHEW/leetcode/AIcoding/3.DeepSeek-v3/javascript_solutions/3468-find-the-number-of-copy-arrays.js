var numberOfArrays = function(nums, m) {
    const MOD = 1e9 + 7;
    const n = nums.length;
    const dp = new Array(n + 1).fill(0);
    dp[n] = 1;

    for (let i = n - 1; i >= 0; i--) {
        if (nums[i] === 0) {
            dp[i] = 0;
            continue;
        }
        let sum = 0;
        let num = 0;
        for (let j = i; j < n; j++) {
            num = num * 10 + nums[j];
            if (num > m) break;
            sum = (sum + dp[j + 1]) % MOD;
        }
        dp[i] = sum;
    }

    return dp[0];
};