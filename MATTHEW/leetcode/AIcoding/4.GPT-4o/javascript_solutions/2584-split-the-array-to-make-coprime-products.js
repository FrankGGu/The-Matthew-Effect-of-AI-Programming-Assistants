var findValidSplit = function(nums) {
    const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);
    const n = nums.length;
    const dp = new Array(n + 1).fill(false);
    dp[n] = true;

    let prefixGcd = 0;
    for (let i = n - 1; i >= 0; i--) {
        prefixGcd = nums[i];
        for (let j = i + 1; j <= n; j++) {
            if (gcd(prefixGcd, nums[j - 1]) === 1) {
                dp[i] = dp[j];
            }
            if (dp[i]) break;
            if (j < n) prefixGcd = gcd(prefixGcd, nums[j]);
        }
    }

    return dp[0];
};