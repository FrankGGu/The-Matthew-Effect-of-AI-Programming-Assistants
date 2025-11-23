function minimumOperations(nums) {
    let operations = 0;
    while (true) {
        let hasNonZero = false;
        for (let i = 0; i < nums.length; i++) {
            if (nums[i] !== 0) {
                hasNonZero = true;
                break;
            }
        }
        if (!hasNonZero) break;
        for (let i = 0; i < nums.length; i++) {
            if (nums[i] !== 0) {
                nums[i]--;
                operations++;
            }
        }
    }
    return operations;
}