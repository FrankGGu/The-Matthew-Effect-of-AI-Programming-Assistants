var find132pattern = function(nums) {
    let n = nums.length;
    if (n < 3) return false;

    let stack = [];
    let third = -Infinity;

    for (let i = n - 1; i >= 0; i--) {
        if (nums[i] < third) return true;
        while (stack.length && nums[i] > stack[stack.length - 1]) {
            third = stack.pop();
        }
        stack.push(nums[i]);
    }

    return false;
};