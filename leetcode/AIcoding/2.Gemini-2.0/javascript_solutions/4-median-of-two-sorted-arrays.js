var findMedianSortedArrays = function(nums1, nums2) {
    const m = nums1.length;
    const n = nums2.length;
    const merged = [];
    let i = 0;
    let j = 0;

    while (i < m && j < n) {
        if (nums1[i] <= nums2[j]) {
            merged.push(nums1[i]);
            i++;
        } else {
            merged.push(nums2[j]);
            j++;
        }
    }

    while (i < m) {
        merged.push(nums1[i]);
        i++;
    }

    while (j < n) {
        merged.push(nums2[j]);
        j++;
    }

    const totalLength = m + n;
    if (totalLength % 2 === 0) {
        const mid = totalLength / 2;
        return (merged[mid - 1] + merged[mid]) / 2;
    } else {
        const mid = Math.floor(totalLength / 2);
        return merged[mid];
    }
};