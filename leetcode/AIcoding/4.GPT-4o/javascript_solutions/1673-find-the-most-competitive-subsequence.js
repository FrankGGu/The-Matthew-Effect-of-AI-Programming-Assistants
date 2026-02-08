var mostCompetitive = function(nums, k) {
    const stack = [];
    const toPop = nums.length - k;

    for (let i = 0; i < nums.length; i++) {
        while (toPop > 0 && stack.length > 0 && stack[stack.length - 1] > nums[i]) {
            stack.pop();
            toPop--;
        }
        stack.push(nums[i]);
    }

    return stack.slice(0, k);
};