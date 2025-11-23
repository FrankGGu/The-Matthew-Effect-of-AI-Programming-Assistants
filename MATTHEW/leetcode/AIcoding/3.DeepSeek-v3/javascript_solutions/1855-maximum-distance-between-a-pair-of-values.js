var maxDistance = function(nums1, nums2) {
    let maxDist = 0;
    let i = 0;
    let j = 0;
    while (i < nums1.length && j < nums2.length) {
        if (nums1[i] > nums2[j]) {
            i++;
        } else {
            maxDist = Math.max(maxDist, j - i);
            j++;
        }
    }
    return maxDist;
};