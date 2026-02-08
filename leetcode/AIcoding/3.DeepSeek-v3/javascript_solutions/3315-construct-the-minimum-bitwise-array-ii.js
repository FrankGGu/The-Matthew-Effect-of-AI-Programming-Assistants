var constructMinimumBitwiseArray = function(nums) {
    const n = nums.length;
    const res = new Array(n).fill(0);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && nums[i] < nums[stack[stack.length - 1]]) {
            const j = stack.pop();
            res[j] = nums[i];
        }
        stack.push(i);
    }

    while (stack.length > 0) {
        const j = stack.pop();
        res[j] = -1;
    }

    return res;
};