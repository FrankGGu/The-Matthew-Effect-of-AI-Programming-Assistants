var expectNumber = function(nums, start, end) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] >= start && nums[i] <= end) {
            count++;
        }
    }
    return count;
};