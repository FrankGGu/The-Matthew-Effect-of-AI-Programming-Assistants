var nextGreaterElements = function(nums) {
    const n = nums.length;
    const result = new Array(n).fill(-1);
    const stack = [];

    for (let i = 0; i < 2 * n; i++) {
        const num = nums[i % n];

        while (stack.length > 0 && num > nums[stack[stack.length - 1]]) {
            result[stack.pop()] = num;
        }

        if (i < n) {
            stack.push(i);
        }
    }

    return result;
};