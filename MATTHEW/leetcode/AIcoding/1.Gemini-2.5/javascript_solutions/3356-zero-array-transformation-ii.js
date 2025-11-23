var minimumOperations = function(nums) {
    let operations = 0;
    let prevNum = 0;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > prevNum) {
            operations += (nums[i] - prevNum);
        }
        prevNum = nums[i];
    }

    return operations;
};