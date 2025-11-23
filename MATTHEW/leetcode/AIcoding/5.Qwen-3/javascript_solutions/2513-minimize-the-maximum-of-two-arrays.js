function minimizeMax(nums1, nums2) {
    nums1.sort((a, b) => a - b);
    nums2.sort((a, b) => a - b);

    let left = 0;
    let right = Math.max(nums1[nums1.length - 1], nums2[nums2.length - 1]) - Math.min(nums1[0], nums2[0]);

    while (left < right) {
        let mid = left + Math.floor((right - left) / 2);
        let i = 0;
        let j = 0;
        let count = 0;

        while (i < nums1.length && j < nums2.length) {
            if (Math.abs(nums1[i] - nums2[j]) <= mid) {
                count++;
                i++;
                j++;
            } else if (nums1[i] < nums2[j]) {
                i++;
            } else {
                j++;
            }
        }

        if (count === Math.min(nums1.length, nums2.length)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}