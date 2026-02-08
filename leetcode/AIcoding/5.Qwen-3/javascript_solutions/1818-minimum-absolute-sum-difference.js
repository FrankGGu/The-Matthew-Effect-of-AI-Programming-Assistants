function minAbsoluteSumDifference(nums1, nums2) {
    const MOD = 1000000007;
    const n = nums1.length;
    let total = 0;
    for (let i = 0; i < n; i++) {
        total += Math.abs(nums1[i] - nums2[i]);
    }

    const sorted = [...nums1].sort((a, b) => a - b);
    let minDiff = total;

    for (let i = 0; i < n; i++) {
        const target = nums2[i];
        let left = 0, right = n - 1;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (sorted[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        let current = Math.abs(sorted[left] - target);
        if (left > 0) {
            current = Math.min(current, Math.abs(sorted[left - 1] - target));
        }
        if (left < n - 1) {
            current = Math.min(current, Math.abs(sorted[left + 1] - target));
        }

        minDiff = Math.min(minDiff, total - Math.abs(nums1[i] - nums2[i]) + current);
    }

    return minDiff % MOD;
}