var maxDotProduct = function(nums1, nums2) {
    const n = nums1.length;
    const m = nums2.length;

    const dp = Array(n + 1).fill(0).map(() => Array(m + 1).fill(-Infinity));

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= m; j++) {
            const currentProduct = nums1[i - 1] * nums2[j - 1];

            // Option 1: Don't include nums1[i-1] in the subsequence from nums1
            const option1 = dp[i - 1][j];

            // Option 2: Don't include nums2[j-1] in the subsequence from nums2
            const option2 = dp[i][j - 1];

            // Option 3: Include both nums1[i-1] and nums2[j-1]
            // This can either start a new subsequence pair (currentProduct)
            // or extend a previous one (currentProduct + dp[i-1][j-1])
            const option3 = Math.max(currentProduct, currentProduct + dp[i - 1][j - 1]);

            dp[i][j] = Math.max(option1, option2, option3);
        }
    }

    return dp[n][m];
};