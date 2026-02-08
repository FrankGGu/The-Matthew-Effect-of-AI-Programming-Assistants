function finalArray(nums, operations) {
    for (const op of operations) {
        for (let i = 0; i < nums.length; i++) {
            nums[i] *= op;
        }
    }
    return nums;
}