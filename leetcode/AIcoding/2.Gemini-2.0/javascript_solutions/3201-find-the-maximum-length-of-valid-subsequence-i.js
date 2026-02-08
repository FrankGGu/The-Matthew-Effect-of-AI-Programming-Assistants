var maxSubsequenceLength = function(nums, ban) {
    const banned = new Set(ban);
    let count = 0;
    for (const num of nums) {
        if (!banned.has(num)) {
            count++;
        }
    }
    return count;
};