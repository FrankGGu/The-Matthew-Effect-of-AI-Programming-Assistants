var sumOfArrayProducts = function(nums, k) {
    const n = nums.length;
    let mod = 10**9 + 7;
    let dp = new Array(n + 1).fill(0);
    dp[0] = 1;
    let sum = 0;

    for (let i = 1; i <= n; i++) {
        let product = 1;
        for (let j = i; j >= 1; j--) {
            product = (product * nums[j - 1]) % mod;
            if (i - j + 1 <= k) {
                dp[i] = (dp[i] + (dp[j - 1] * product) % mod) % mod;
            }
        }
    }

    return dp[n];
};