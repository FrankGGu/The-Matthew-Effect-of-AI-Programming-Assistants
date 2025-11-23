var twoOutOfThree = function(nums1, nums2, nums3) {
    const set1 = new Set(nums1);
    const set2 = new Set(nums2);
    const set3 = new Set(nums3);

    const counts = new Map();

    for (const num of set1) {
        counts.set(num, (counts.get(num) || 0) + 1);
    }
    for (const num of set2) {
        counts.set(num, (counts.get(num) || 0) + 1);
    }
    for (const num of set3) {
        counts.set(num, (counts.get(num) || 0) + 1);
    }

    const result = [];
    for (const [num, count] of counts.entries()) {
        if (count >= 2) {
            result.push(num);
        }
    }

    return result;
};