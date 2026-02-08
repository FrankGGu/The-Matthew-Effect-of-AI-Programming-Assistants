var maxSumMinProduct = function(nums) {
    const n = nums.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

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

    let maxProduct = 0;
    for (let i = 0; i < n; i++) {
        const l = left[i] + 1;
        const r = right[i] - 1;
        const sum = prefix[r + 1] - prefix[l];
        const product = BigInt(nums[i]) * BigInt(sum);
        if (product > maxProduct) {
            maxProduct = product;
        }
    }

    return maxProduct % BigInt(1e9 + 7);
};