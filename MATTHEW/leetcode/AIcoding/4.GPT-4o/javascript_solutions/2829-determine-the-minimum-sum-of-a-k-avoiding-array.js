function minimumSum(k, nums) {
    const n = nums.length;
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = n; j >= 0; j--) {
            if (j >= nums[i - 1]) {
                dp[j] = (dp[j] + dp[j - nums[i - 1]]) % (1e9 + 7);
            }
        }
    }

    let result = 0;
    for (let i = 0; i <= n; i++) {
        if (dp[i] >= k) {
            result = i;
            break;
        }
    }

    return result;
}