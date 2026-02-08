var minOperations = function(nums) {
    let operations = 0;
    while (true) {
        let allZero = true;
        let hasNonZero = false;
        for (let i = 0; i < nums.length; i++) {
            if (nums[i] !== 0) {
                allZero = false;
                if (nums[i] % 2 !== 0) {
                    nums[i]--;
                    operations++;
                }
                if (nums[i] !== 0) {
                    hasNonZero = true;
                }
            }
        }
        if (allZero) {
            break;
        }
        if (hasNonZero) {
            for (let i = 0; i < nums.length; i++) {
                nums[i] /= 2;
            }
            operations++;
        }
    }
    return operations;
};