var twoOutOfThree = function(nums1, nums2, nums3) {
    const count = {};

    for (const num of nums1) {
        count[num] = (count[num] || 0) | 1;
    }

    for (const num of nums2) {
        count[num] = (count[num] || 0) | 2;
    }

    for (const num of nums3) {
        count[num] = (count[num] || 0) | 4;
    }

    return Object.keys(count).filter(num => count[num] >= 3).map(Number);
};