var maxSumMinProduct = function(nums) {
    const mod = 1e9 + 7;
    const n = nums.length;
    const prefixSum = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    const stack = [];
    let result = 0;

    for (let i = 0; i <= n; i++) {
        while (stack.length && (i === n || nums[stack[stack.length - 1]] > nums[i])) {
            const j = stack.pop();
            const sum = prefixSum[i] - prefixSum[stack.length ? stack[stack.length - 1] + 1 : 0];
            result = Math.max(result, sum * nums[j]);
        }
        stack.push(i);
    }

    return result % mod;
};