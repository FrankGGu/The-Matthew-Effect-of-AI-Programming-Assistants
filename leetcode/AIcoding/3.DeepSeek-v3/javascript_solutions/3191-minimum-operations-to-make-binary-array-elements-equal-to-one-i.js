var minOperations = function(nums) {
    let operations = 0;
    for (let i = 0; i < nums.length - 1; i++) {
        if (nums[i] === 0) {
            nums[i] ^= 1;
            nums[i + 1] ^= 1;
            operations++;
        }
    }
    return nums[nums.length - 1] === 1 ? operations : -1;
};