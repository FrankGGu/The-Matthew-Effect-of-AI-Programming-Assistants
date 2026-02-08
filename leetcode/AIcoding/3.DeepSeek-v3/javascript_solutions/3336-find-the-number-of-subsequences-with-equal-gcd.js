var countSubsequences = function(nums, k) {
    const MOD = 1e9 + 7;
    const maxNum = Math.max(...nums);
    const dp = new Array(maxNum + 1).fill(0);
    let result = 0;

    for (const num of nums) {
        for (let g = num; g >= 1; g--) {
            const complement = num / g;
            if (complement % 1 !== 0) continue;
            const current = dp[g];
            dp[g] = (dp[g] + (g === num ? 1 : current)) % MOD;
        }
    }

    for (let g = 1; g <= maxNum; g++) {
        if (g === k) {
            result = (result + dp[g]) % MOD;
        }
    }

    return result;
};