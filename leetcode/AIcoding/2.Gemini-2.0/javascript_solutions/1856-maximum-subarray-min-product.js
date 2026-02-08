var maxSumMinProduct = function(nums) {
    const n = nums.length;
    const MOD = 10**9 + 7;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);
    const stack = [];
    let prefixSum = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = (prefixSum[i] + nums[i]);
    }

    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && nums[stack[stack.length - 1]] >= nums[i]) {
            stack.pop();
        }
        left[i] = stack.length === 0 ? 0 : stack[stack.length - 1] + 1;
        stack.push(i);
    }

    stack.length = 0;

    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && nums[stack[stack.length - 1]] > nums[i]) {
            stack.pop();
        }
        right[i] = stack.length === 0 ? n - 1 : stack[stack.length - 1] - 1;
        stack.push(i);
    }

    let maxProduct = 0;
    for (let i = 0; i < n; i++) {
        let sum = prefixSum[right[i] + 1] - prefixSum[left[i]];
        maxProduct = Math.max(maxProduct, nums[i] * sum);
    }

    return maxProduct % MOD;
};