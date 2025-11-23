var findDuplicates = function(nums) {
    let result = [];
    for (let i = 0; i < nums.length; i++) {
        let index = Math.abs(nums[i]) - 1;
        if (nums[index] < 0) {
            result.push(index + 1);
        }
        nums[index] = -nums[index];
    }
    return result;
};