var getSumAbsoluteDifferences = function(nums) {
    const n = nums.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        const leftSum = nums[i] * i - prefixSum[i];
        const rightSum = (prefixSum[n] - prefixSum[i + 1]) - nums[i] * (n - 1 - i);
        result.push(leftSum + rightSum);
    }
    return result;
};