var twoOutOfThree = function(nums1, nums2, nums3) {
    const set1 = new Set(nums1);
    const set2 = new Set(nums2);
    const set3 = new Set(nums3);
    const count = {};

    const updateCount = (set) => {
        set.forEach(num => {
            count[num] = (count[num] || 0) + 1;
        });
    };

    updateCount(set1);
    updateCount(set2);
    updateCount(set3);

    const result = [];
    for (const num in count) {
        if (count[num] >= 2) {
            result.push(parseInt(num));
        }
    }

    return result;
};