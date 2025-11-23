var findDifference = function(nums1, nums2) {
    const set1 = new Set(nums1);
    const set2 = new Set(nums2);
    const answer1 = [];
    const answer2 = [];

    for (const num of set1) {
        if (!set2.has(num)) {
            answer1.push(num);
        }
    }

    for (const num of set2) {
        if (!set1.has(num)) {
            answer2.push(num);
        }
    }

    return [answer1, answer2];
};