var minAbsoluteSumDiff = function(nums1, nums2) {
    const mod = 1e9 + 7;
    const n = nums1.length;
    const sorted = [...nums1].sort((a, b) => a - b);
    let total = 0;
    let maxDiff = 0;

    for (let i = 0; i < n; i++) {
        const diff = Math.abs(nums1[i] - nums2[i]);
        total = (total + diff) % mod;

        let left = 0, right = n - 1;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (sorted[mid] < nums2[i]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        const closest1 = Math.abs(sorted[left] - nums2[i]);
        const closest2 = left > 0 ? Math.abs(sorted[left - 1] - nums2[i]) : Infinity;
        const minClosest = Math.min(closest1, closest2);
        const currentDiff = diff - minClosest;

        if (currentDiff > maxDiff) {
            maxDiff = currentDiff;
        }
    }

    return (total - maxDiff + mod) % mod;
};