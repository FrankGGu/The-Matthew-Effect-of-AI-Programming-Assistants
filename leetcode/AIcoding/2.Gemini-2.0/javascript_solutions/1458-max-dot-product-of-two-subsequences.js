var maxDotProduct = function(nums1, nums2) {
    const m = nums1.length;
    const n = nums2.length;
    const dp = Array(m + 1).fill(null).map(() => Array(n + 1).fill(-Infinity));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            dp[i][j] = Math.max(
                nums1[i - 1] * nums2[j - 1],
                dp[i - 1][j],
                dp[i][j - 1],
                dp[i - 1][j - 1] + nums1[i - 1] * nums2[j - 1]
            );
        }
    }

    return dp[m][n];
};