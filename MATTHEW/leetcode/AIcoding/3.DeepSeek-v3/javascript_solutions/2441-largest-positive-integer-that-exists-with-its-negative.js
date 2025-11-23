var findMaxK = function(nums) {
    const numSet = new Set(nums);
    let maxK = -1;
    for (const num of nums) {
        if (num > 0 && numSet.has(-num)) {
            maxK = Math.max(maxK, num);
        }
    }
    return maxK;
};