var countAlmostEqualPairs = function(nums) {
    let count = 0;
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i !== j && Math.abs(nums[i] - nums[j]) <= 1) {
                count++;
            }
        }
    }
    return count;
};