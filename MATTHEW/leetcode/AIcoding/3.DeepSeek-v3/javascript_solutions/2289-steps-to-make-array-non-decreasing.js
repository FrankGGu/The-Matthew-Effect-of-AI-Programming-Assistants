var totalSteps = function(nums) {
    let stack = [];
    let maxSteps = 0;
    let steps = new Array(nums.length).fill(0);

    for (let i = nums.length - 1; i >= 0; i--) {
        while (stack.length > 0 && nums[i] > nums[stack[stack.length - 1]]) {
            steps[i] = Math.max(steps[i] + 1, steps[stack[stack.length - 1]]);
            stack.pop();
        }
        stack.push(i);
        maxSteps = Math.max(maxSteps, steps[i]);
    }

    return maxSteps;
};