var minAbsoluteSumDifference = function(nums1, nums2) {
    const n = nums1.length;
    let sum = 0;
    for (let i = 0; i < n; i++) {
        sum = (sum + Math.abs(nums1[i] - nums2[i])) % (10**9 + 7);
    }

    const sortedNums1 = [...nums1].sort((a, b) => a - b);
    let maxDiff = 0;

    for (let i = 0; i < n; i++) {
        const diff = Math.abs(nums1[i] - nums2[i]);
        let left = 0;
        let right = n - 1;
        let closest = Infinity;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            closest = Math.abs(sortedNums1[mid] - nums2[i]) < Math.abs(closest - nums2[i]) ? sortedNums1[mid] : closest;
            if (sortedNums1[mid] < nums2[i]) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        let potentialDiff = Math.abs(closest - nums2[i]);

        maxDiff = Math.max(maxDiff, diff - potentialDiff);
    }

    return (sum - maxDiff + (10**9 + 7)) % (10**9 + 7);
};