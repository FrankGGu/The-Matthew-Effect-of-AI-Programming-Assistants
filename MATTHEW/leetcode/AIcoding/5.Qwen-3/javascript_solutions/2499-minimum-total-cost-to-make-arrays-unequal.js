function minTotalCostToMakeArraysUnequal(nums1, nums2) {
    const n = nums1.length;
    const m = nums2.length;
    const MOD = 10 ** 9 + 7;

    let totalCost = 0;

    for (let i = 0; i < Math.min(n, m); i++) {
        if (nums1[i] === nums2[i]) {
            totalCost += Math.abs(nums1[i] - nums2[i]);
        }
    }

    return totalCost % MOD;
}