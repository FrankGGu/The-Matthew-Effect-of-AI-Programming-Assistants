var findLargestAlmostMissingInteger = function(nums) {
    const numSet = new Set(nums);
    let maxAlmostMissing = 0;

    for (const num of nums) {
        if (!numSet.has(num + 1)) {
            maxAlmostMissing = Math.max(maxAlmostMissing, num + 1);
        }
    }

    return maxAlmostMissing;
};