var intersect = function(nums1, nums2) {
    const freqMap = new Map();
    for (const num of nums1) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    const result = [];
    for (const num of nums2) {
        if (freqMap.has(num) && freqMap.get(num) > 0) {
            result.push(num);
            freqMap.set(num, freqMap.get(num) - 1);
        }
    }

    return result;
};