var distinctDifferenceArray = function(nums) {
    const n = nums.length;
    const result = [];
    for (let i = 0; i < n; i++) {
        const prefix = new Set();
        for (let j = 0; j <= i; j++) {
            prefix.add(nums[j]);
        }
        const suffix = new Set();
        for (let j = i + 1; j < n; j++) {
            suffix.add(nums[j]);
        }
        result.push(prefix.size - suffix.size);
    }
    return result;
};