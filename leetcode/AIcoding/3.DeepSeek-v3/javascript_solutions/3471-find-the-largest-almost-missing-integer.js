var findLargestAlmostMissingInteger = function(nums) {
    const set = new Set(nums);
    let max = -1;
    for (const num of nums) {
        if (!set.has(num + 1) && num > max) {
            max = num;
        }
    }
    return max;
};