function maxSubarrayMinProduct(nums) {
    const MOD = 1000000007;
    let max = 0;
    const stack = [];
    const left = new Array(nums.length).fill(-1);
    const right = new Array(nums.length).fill(nums.length);

    for (let i = 0; i < nums.length; i++) {
        while (stack.length > 0 && nums[stack[stack.length - 1]] >= nums[i]) {
            stack.pop();
        }
        if (stack.length > 0) {
            left[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    stack.length = 0;

    for (let i = nums.length - 1; i >= 0; i--) {
        while (stack.length > 0 && nums[stack[stack.length - 1]] >= nums[i]) {
            stack.pop();
        }
        if (stack.length > 0) {
            right[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    for (let i = 0; i < nums.length; i++) {
        const count = right[i] - left[i] - 1;
        const sum = (nums[i] * count) % MOD;
        max = Math.max(max, sum);
    }

    return max;
}