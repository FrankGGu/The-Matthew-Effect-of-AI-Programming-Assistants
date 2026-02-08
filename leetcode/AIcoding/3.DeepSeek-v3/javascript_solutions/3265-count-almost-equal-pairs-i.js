var countAlmostEqualPairs = function(nums) {
    let count = 0;
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const diff = Math.abs(nums[i] - nums[j]);
            if (diff <= 1) {
                count++;
            }
        }
    }
    return count;
};