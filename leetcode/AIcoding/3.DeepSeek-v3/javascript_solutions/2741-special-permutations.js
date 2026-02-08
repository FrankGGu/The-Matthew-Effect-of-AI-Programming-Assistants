var specialPerm = function(nums) {
    const MOD = 1e9 + 7;
    const n = nums.length;
    const memo = new Array(n).fill().map(() => new Array(1 << n).fill(-1));

    function dp(last, mask) {
        if (mask === (1 << n) - 1) {
            return 1;
        }
        if (memo[last][mask] !== -1) {
            return memo[last][mask];
        }
        let res = 0;
        for (let i = 0; i < n; i++) {
            if (!(mask & (1 << i))) {
                if (mask === 0 || nums[last] % nums[i] === 0 || nums[i] % nums[last] === 0) {
                    res = (res + dp(i, mask | (1 << i))) % MOD;
                }
            }
        }
        memo[last][mask] = res;
        return res;
    }

    return dp(0, 0);
};