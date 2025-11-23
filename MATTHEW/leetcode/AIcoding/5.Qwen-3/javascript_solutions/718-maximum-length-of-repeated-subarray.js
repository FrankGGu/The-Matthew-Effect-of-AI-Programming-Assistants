function maxLength(nums1, nums2) {
    const m = nums1.length;
    const n = nums2.length;
    const dp = new Array(m + 1).fill(0).map(() => new Array(n + 1).fill(0));
    let maxLength = 0;

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            if (nums1[i - 1] === nums2[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + 1;
                maxLength = Math.max(maxLength, dp[i][j]);
            }
        }
    }

    return maxLength;
}