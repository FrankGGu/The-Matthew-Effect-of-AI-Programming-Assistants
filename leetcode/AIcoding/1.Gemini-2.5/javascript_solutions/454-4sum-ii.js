var fourSumCount = function(nums1, nums2, nums3, nums4) {
    const sumMap = new Map();
    let count = 0;

    for (const n1 of nums1) {
        for (const n2 of nums2) {
            const sum = n1 + n2;
            sumMap.set(sum, (sumMap.get(sum) || 0) + 1);
        }
    }

    for (const n3 of nums3) {
        for (const n4 of nums4) {
            const target = -(n3 + n4);
            if (sumMap.has(target)) {
                count += sumMap.get(target);
            }
        }
    }

    return count;
};