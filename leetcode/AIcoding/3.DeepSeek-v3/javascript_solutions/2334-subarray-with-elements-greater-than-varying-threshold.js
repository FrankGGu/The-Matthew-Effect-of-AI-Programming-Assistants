var validSubarraySize = function(nums, threshold) {
    const n = nums.length;
    const left = new Array(n).fill(-1);
    const right = new Array(n).fill(n);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length && nums[stack[stack.length - 1]] >= nums[i]) {
            stack.pop();
        }
        if (stack.length) {
            left[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    stack.length = 0;

    for (let i = n - 1; i >= 0; i--) {
        while (stack.length && nums[stack[stack.length - 1]] >= nums[i]) {
            stack.pop();
        }
        if (stack.length) {
            right[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    for (let i = 0; i < n; i++) {
        const k = right[i] - left[i] - 1;
        if (nums[i] > threshold / k) {
            return k;
        }
    }

    return -1;
};