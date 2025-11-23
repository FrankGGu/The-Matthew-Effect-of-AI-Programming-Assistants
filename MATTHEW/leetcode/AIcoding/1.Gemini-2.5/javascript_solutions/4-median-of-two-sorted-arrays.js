var findMedianSortedArrays = function(nums1, nums2) {
    const m = nums1.length;
    const n = nums2.length;
    const totalLength = m + n;

    if (totalLength % 2 === 1) {
        return findKthElement(nums1, 0, nums2, 0, Math.floor(totalLength / 2) + 1);
    } else {
        const mid1 = findKthElement(nums1, 0, nums2, 0, totalLength / 2);
        const mid2 = findKthElement(nums1, 0, nums2, 0, totalLength / 2 + 1);
        return (mid1 + mid2) / 2;
    }
};

function findKthElement(nums1, nums1Start, nums2, nums2Start, k) {
    if (nums1.length - nums1Start > nums2.length - nums2Start) {
        return findKthElement(nums2, nums2Start, nums1, nums1Start, k);
    }

    if (nums1Start >= nums1.length) {
        return nums2[nums2Start + k - 1];
    }

    if (k === 1) {
        return Math.min(nums1[nums1Start], nums2[nums2Start]);
    }

    let halfK = Math.floor(k / 2);

    let val1 = (nums1Start + halfK - 1 < nums1.length) ? nums1[nums1Start + halfK - 1] : Infinity;
    let val2 = (nums2Start + halfK - 1 < nums2.length) ? nums2[nums2Start + halfK - 1] : Infinity;

    if (val1 < val2) {
        return findKthElement(nums1, nums1Start + halfK, nums2, nums2Start, k - halfK);
    } else {
        return findKthElement(nums1, nums1Start, nums2, nums2Start + halfK, k - halfK);
    }
}