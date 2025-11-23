function maxNonDecreasingSubarray(nums1, nums2) {
    let n = nums1.length;
    let maxLen = 1;
    let len1 = 1;
    let len2 = 1;

    for (let i = 1; i < n; i++) {
        if (nums1[i] >= nums1[i - 1]) {
            len1++;
        } else {
            len1 = 1;
        }

        if (nums2[i] >= nums2[i - 1]) {
            len2++;
        } else {
            len2 = 1;
        }

        if (nums1[i] >= nums2[i - 1]) {
            len1 = Math.max(len1, len2 + 1);
        }

        if (nums2[i] >= nums1[i - 1]) {
            len2 = Math.max(len2, len1 + 1);
        }

        maxLen = Math.max(maxLen, len1, len2);
    }

    return maxLen;
}