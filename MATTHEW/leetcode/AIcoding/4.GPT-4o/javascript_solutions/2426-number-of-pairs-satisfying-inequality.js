var countPairs = function(nums1, nums2, diff) {
    const n = nums1.length;
    const combined = new Array(n);
    for (let i = 0; i < n; i++) {
        combined[i] = nums1[i] - nums2[i];
    }
    combined.sort((a, b) => a - b);

    let count = 0;
    for (let i = 0; i < n; i++) {
        const target = combined[i] + diff;
        let left = 0, right = n;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (combined[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        count += left;
    }

    return count;
};