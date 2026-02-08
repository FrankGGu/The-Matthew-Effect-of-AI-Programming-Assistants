var maxWidthRamp = function(nums) {
    const stack = [];
    let max = 0;
    for (let i = 0; i < nums.length; i++) {
        if (stack.length === 0 || nums[i] < nums[stack[stack.length - 1]]) {
            stack.push(i);
        }
    }
    for (let i = nums.length - 1; i >= 0; i--) {
        while (stack.length > 0 && nums[i] >= nums[stack[stack.length - 1]]) {
            max = Math.max(max, i - stack.pop());
        }
    }
    return max;
};