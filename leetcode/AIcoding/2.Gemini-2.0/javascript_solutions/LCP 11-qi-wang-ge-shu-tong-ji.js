var expectNumber = function(nums) {
    if (!nums || nums.length === 0) {
        return 0;
    }
    nums.sort((a, b) => a - b);
    let count = 1;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] !== nums[i - 1]) {
            count++;
        }
    }
    return count;
};