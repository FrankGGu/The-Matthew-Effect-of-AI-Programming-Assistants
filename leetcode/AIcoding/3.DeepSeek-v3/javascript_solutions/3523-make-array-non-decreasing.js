var totalSteps = function(nums) {
    let stack = [];
    let maxSteps = 0;
    for (let num of nums) {
        let currentSteps = 0;
        while (stack.length > 0 && stack[stack.length - 1][0] <= num) {
            currentSteps = Math.max(currentSteps, stack.pop()[1]);
        }
        if (stack.length > 0) {
            currentSteps++;
        } else {
            currentSteps = 0;
        }
        maxSteps = Math.max(maxSteps, currentSteps);
        stack.push([num, currentSteps]);
    }
    return maxSteps;
};