function minOperations(nums) {
    let maxNum = Math.max(...nums);
    let operations = 0;

    while (maxNum > 0) {
        operations++;
        for (let i = 0; i < nums.length; i++) {
            if (nums[i] > 0) {
                nums[i] -= 1;
            }
        }
        maxNum = Math.max(...nums);
    }

    return operations;
}