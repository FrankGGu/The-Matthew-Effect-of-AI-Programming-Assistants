var minimumXORSum = function(nums1, nums2) {
    const n = nums1.length;
    const dp = Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        const count = mask.toString(2).split(' ').join('').length;
        if (count > nums2.length) continue;

        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) === 0) {
                const newMask = mask | (1 << i);
                dp[newMask] = Math.min(dp[newMask], dp[mask] + (nums1[i] ^ nums2[count]));
            }
        }
    }

    return dp[(1 << n) - 1];
};