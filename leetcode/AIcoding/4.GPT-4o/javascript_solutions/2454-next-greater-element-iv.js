var findGreaterNums = function(nums) {
    const n = nums.length;
    const result = new Array(n).fill(0);
    const stack = [];
    const count = new Map();

    for (let i = 0; i < n; i++) {
        count.set(nums[i], (count.get(nums[i]) || 0) + 1);
    }

    for (let i = 0; i < n; i++) {
        while (stack.length && nums[stack[stack.length - 1]] < nums[i]) {
            const index = stack.pop();
            result[index] = nums[i];
        }
        stack.push(i);
    }

    for (let i = 0; i < n; i++) {
        if (result[i] === 0) {
            result[i] = -1;
        }
    }

    return result.map(num => count.get(num) || 0);
};