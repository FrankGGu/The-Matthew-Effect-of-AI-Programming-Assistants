var minimumTime = function(nums1, nums2, x) {
    const n = nums1.length;
    const indices = Array.from({ length: n }, (_, i) => i);
    indices.sort((a, b) => nums2[a] - nums2[b]);

    const dp = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        const idx = indices[i];
        const a = nums1[idx];
        const b = nums2[idx];
        for (let j = i + 1; j > 0; j--) {
            dp[j] = Math.max(dp[j], dp[j - 1] + a + b * j);
        }
    }

    const sum1 = nums1.reduce((a, b) => a + b, 0);
    const sum2 = nums2.reduce((a, b) => a + b, 0);

    for (let t = 0; t <= n; t++) {
        if (sum1 + sum2 * t - dp[t] <= x) {
            return t;
        }
    }

    return -1;
};