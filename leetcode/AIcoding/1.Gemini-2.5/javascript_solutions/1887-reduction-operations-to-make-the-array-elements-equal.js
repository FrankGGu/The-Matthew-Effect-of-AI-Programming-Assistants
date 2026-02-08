var reductionOperations = function(nums) {
    nums.sort((a, b) => a - b);

    let totalOperations = 0;
    let currentSteps = 0;

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] > nums[i - 1]) {
            currentSteps++;
        }
        totalOperations += currentSteps;
    }

    return totalOperations;
};