var sumOfPower = function(nums, k) {
    const MOD = 1e9 + 7;
    const n = nums.length;
    const dp = new Array(k + 1).fill(0).map(() => new Array(n + 1).fill(0));
    dp[0][0] = 1;

    for (const num of nums) {
        for (let i = k; i >= 0; i--) {
            for (let j = n; j >= 0; j--) {
                if (i >= num && j >= 1) {
                    dp[i][j] = (dp[i][j] + dp[i - num][j - 1]) % MOD;
                }
            }
        }
    }

    let result = 0;
    for (let j = 1; j <= n; j++) {
        let ways = dp[k][j];
        let power = 1;
        for (let i = 0; i < n - j; i++) {
            power = (power * 2) % MOD;
        }
        result = (result + ways * power) % MOD;
    }

    return result;
};