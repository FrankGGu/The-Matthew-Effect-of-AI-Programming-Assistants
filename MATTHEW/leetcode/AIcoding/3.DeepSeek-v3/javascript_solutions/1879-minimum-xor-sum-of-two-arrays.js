var minimumXORSum = function(nums1, nums2) {
    const n = nums1.length;
    const dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        const k = countSetBits(mask);
        for (let i = 0; i < n; i++) {
            if (!(mask & (1 << i))) {
                const newMask = mask | (1 << i);
                dp[newMask] = Math.min(dp[newMask], dp[mask] + (nums1[k] ^ nums2[i]));
            }
        }
    }

    return dp[(1 << n) - 1];
};

function countSetBits(num) {
    let count = 0;
    while (num > 0) {
        count += num & 1;
        num >>= 1;
    }
    return count;
}