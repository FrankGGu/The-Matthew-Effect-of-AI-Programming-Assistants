var fourSumCount = function(nums1, nums2, nums3, nums4) {
    const sumMap = new Map();
    for (let i = 0; i < nums1.length; i++) {
        for (let j = 0; j < nums2.length; j++) {
            const sum = nums1[i] + nums2[j];
            sumMap.set(sum, (sumMap.get(sum) || 0) + 1);
        }
    }

    let count = 0;
    for (let i = 0; i < nums3.length; i++) {
        for (let j = 0; j < nums4.length; j++) {
            const sum = nums3[i] + nums4[j];
            count += (sumMap.get(-sum) || 0);
        }
    }

    return count;
};