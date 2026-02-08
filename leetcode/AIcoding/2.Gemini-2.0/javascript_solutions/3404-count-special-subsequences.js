var countSpecialSubsequences = function(nums) {
    const MOD = 10**9 + 7;
    let dp0 = 0;
    let dp1 = 0;
    let dp2 = 0;

    for (const num of nums) {
        if (num === 0) {
            dp0 = (2 * dp0 + 1) % MOD;
        } else if (num === 1) {
            dp1 = (2 * dp1 + dp0) % MOD;
        } else {
            dp2 = (2 * dp2 + dp1) % MOD;
        }
    }

    return dp2;
};