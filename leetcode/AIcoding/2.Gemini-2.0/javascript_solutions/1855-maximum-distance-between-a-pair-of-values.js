var maxDistance = function(nums1, nums2) {
    let max_dist = 0;
    let i = 0;
    let j = 0;

    while (i < nums1.length && j < nums2.length) {
        if (nums1[i] <= nums2[j]) {
            max_dist = Math.max(max_dist, j - i);
            j++;
        } else {
            i++;
        }
    }

    return max_dist;
};