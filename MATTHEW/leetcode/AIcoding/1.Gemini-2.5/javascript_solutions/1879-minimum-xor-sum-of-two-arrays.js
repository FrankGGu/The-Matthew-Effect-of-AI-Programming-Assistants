var minimumXORSum = function(nums1, nums2) {
    const n = nums1.length;
    const dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 1; mask < (1 << n); mask++) {
        let k = 0;
        let tempMask = mask;
        while (tempMask > 0) {
            tempMask &= (tempMask - 1);
            k++;
        }

        const nums1_idx = k - 1;

        for (let j = 0; j < n; j++) {
            if ((mask >> j) & 1) {
                dp[mask] = Math.min(dp[mask], dp[mask ^ (1 << j)] + (nums1[nums1_idx] ^ nums2[j]));
            }
        }
    }

    return dp[(1 << n) - 1];
};