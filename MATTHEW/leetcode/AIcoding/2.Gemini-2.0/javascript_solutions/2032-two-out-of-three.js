var twoOutOfThree = function(nums1, nums2, nums3) {
    const set1 = new Set(nums1);
    const set2 = new Set(nums2);
    const set3 = new Set(nums3);
    const result = new Set();

    for (const num of set1) {
        if (set2.has(num) || set3.has(num)) {
            result.add(num);
        }
    }

    for (const num of set2) {
        if (set1.has(num) || set3.has(num)) {
            result.add(num);
        }
    }

    for (const num of set3) {
        if (set1.has(num) || set2.has(num)) {
            result.add(num);
        }
    }

    return Array.from(result);
};