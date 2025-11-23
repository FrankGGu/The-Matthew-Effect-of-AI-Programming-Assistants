var minOperations = function(nums) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 0) {
            count++;
            if (i + 1 < nums.length) {
                nums[i + 1] = 1 - nums[i + 1];
            }
        }
    }
    return count;
};