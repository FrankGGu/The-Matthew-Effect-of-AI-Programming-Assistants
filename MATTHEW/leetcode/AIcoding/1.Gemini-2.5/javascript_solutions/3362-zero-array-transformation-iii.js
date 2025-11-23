var minOperations = function(nums) {
    let operations = 0;
    let currentDecrease = 0;

    for (let i = 0; i < nums.length; i++) {
        const actualValue = nums[i] - currentDecrease;
        if (actualValue > 0) {
            operations += actualValue;
            currentDecrease += actualValue;
        }
    }

    return operations;
};