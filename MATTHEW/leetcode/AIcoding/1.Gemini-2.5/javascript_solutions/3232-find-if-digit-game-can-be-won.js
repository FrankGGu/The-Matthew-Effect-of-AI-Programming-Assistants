var canAliceWin = function(nums1, nums2) {
    let sum1 = 0;
    for (let i = 0; i < nums1.length; i++) {
        sum1 += nums1[i];
    }

    let sum2 = 0;
    for (let i = 0; i < nums2.length; i++) {
        sum2 += nums2[i];
    }

    return sum1 > sum2;
};