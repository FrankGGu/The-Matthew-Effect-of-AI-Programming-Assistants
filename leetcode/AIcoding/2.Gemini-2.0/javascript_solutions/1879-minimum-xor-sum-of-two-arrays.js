var minimumXORSum = function(nums1, nums2) {
    const n = nums1.length;
    const dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        const count = mask.toString(2).split('').filter(bit => bit === '1').length;
        if (count === n) continue;

        for (let i = 0; i < n; i++) {
            if (!(mask & (1 << i))) {
                dp[mask | (1 << i)] = Math.min(dp[mask | (1 << i)], dp[mask] + (nums1[count] ^ nums2[i]));
            }
        }
    }

    return dp[(1 << n) - 1];
};