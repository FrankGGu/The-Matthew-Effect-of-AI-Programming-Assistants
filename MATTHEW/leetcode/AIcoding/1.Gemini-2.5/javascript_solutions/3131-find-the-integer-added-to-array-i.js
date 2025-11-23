var findTheIntegerAdded = function(nums1, nums2) {
    const min1 = Math.min(...nums1);
    const min2 = Math.min(...nums2);
    return min2 - min1;
};