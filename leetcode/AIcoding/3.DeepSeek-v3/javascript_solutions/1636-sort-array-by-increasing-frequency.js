var frequencySort = function(nums) {
    const frequencyMap = {};
    for (const num of nums) {
        frequencyMap[num] = (frequencyMap[num] || 0) + 1;
    }

    return nums.sort((a, b) => {
        if (frequencyMap[a] === frequencyMap[b]) {
            return b - a;
        } else {
            return frequencyMap[a] - frequencyMap[b];
        }
    });
};