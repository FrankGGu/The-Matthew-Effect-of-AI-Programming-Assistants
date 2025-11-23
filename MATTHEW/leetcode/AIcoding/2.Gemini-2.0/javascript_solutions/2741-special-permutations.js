var specialPerm = function(nums) {
    const n = nums.length;
    const MOD = 10**9 + 7;
    let dp = new Array(1 << n).fill(0);
    dp[0] = 1;

    for (let mask = 0; mask < (1 << n); mask++) {
        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) === 0) {
                if (mask === 0 || (nums[i] % nums[getLastBit(mask)] === 0 || nums[getLastBit(mask)] % nums[i] === 0)) {
                    dp[mask | (1 << i)] = (dp[mask | (1 << i)] + dp[mask]) % MOD;
                }
            }
        }
    }

    return dp[(1 << n) - 1];

    function getLastBit(mask) {
        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) !== 0) {
                return i;
            }
        }
        return -1;
    }
};