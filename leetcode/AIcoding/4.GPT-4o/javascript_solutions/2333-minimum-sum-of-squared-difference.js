var minSumSquareDiff = function(nums1, nums2, k) {
    const n = nums1.length;
    const diffs = new Array(n);

    for (let i = 0; i < n; i++) {
        diffs[i] = Math.abs(nums1[i] - nums2[i]);
    }

    let left = 0, right = Math.max(...diffs);

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        let total = 0;
        for (const d of diffs) {
            total += Math.max(0, d - mid);
        }
        if (total > k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    const minDiff = left;
    let total = 0;
    for (const d of diffs) {
        total += Math.max(0, d - minDiff);
    }

    const remaining = k - total;
    let result = 0;

    for (const d of diffs) {
        const newDiff = Math.max(0, d - minDiff - Math.min(remaining, d - minDiff));
        result += newDiff * newDiff;
        remaining -= Math.max(0, d - minDiff) - Math.max(0, newDiff);
        if (remaining <= 0) break;
    }

    return result + remaining * remaining;
};