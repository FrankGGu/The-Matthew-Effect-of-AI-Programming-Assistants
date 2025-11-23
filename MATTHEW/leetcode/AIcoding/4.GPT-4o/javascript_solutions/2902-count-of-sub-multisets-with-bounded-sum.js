var countSubsets = function(nums, limit) {
    const mod = 1000000007;
    const n = nums.length;
    const dp = new Array(limit + 1).fill(0);
    dp[0] = 1;

    for (let num of nums) {
        for (let j = limit; j >= num; j--) {
            dp[j] = (dp[j] + dp[j - num]) % mod;
        }
    }

    let result = 0;
    for (let i = 1; i <= limit; i++) {
        result = (result + dp[i]) % mod;
    }

    return result;
};