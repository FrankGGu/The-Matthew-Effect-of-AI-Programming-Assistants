function applyOperations(nums, op1, op2) {
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === op1) {
            nums[i] = op2;
        }
    }
    return nums;
}