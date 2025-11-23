var findLength = function(nums1, nums2) {
    const m = nums1.length;
    const n = nums2.length;

    // dp[i][j] will store the maximum length of a common subarray ending at nums1[i-1] and nums2[j-1]
    const dp = Array(m + 1).fill(0).map(() => Array(n + 1).fill(0));

    let maxLength = 0;

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            if (nums1[i - 1] === nums2[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + 1;
                maxLength = Math.max(maxLength, dp[i][j]);
            }
            // If nums1[i-1] !== nums2[j-1], dp[i][j] remains 0, which is its default initialized value.
        }
    }

    return maxLength;
};