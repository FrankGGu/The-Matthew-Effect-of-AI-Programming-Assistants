var subarrayRanges = function(nums) {
    let n = nums.length;
    let total = 0;

    for (let i = 0; i < n; i++) {
        let max = nums[i];
        let min = nums[i];
        for (let j = i + 1; j < n; j++) {
            max = Math.max(max, nums[j]);
            min = Math.min(min, nums[j]);
            total += max - min;
        }
    }

    return total;
};