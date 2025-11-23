var getSumAbsoluteDifferences = function(nums) {
    const n = nums.length;
    const result = new Array(n).fill(0);
    const prefixSum = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        prefixSum[i] = prefixSum[i - 1] + nums[i - 1];
    }

    for (let i = 0; i < n; i++) {
        result[i] = (nums[i] * (i + 1)) - prefixSum[i + 1] + (prefixSum[n] - prefixSum[i + 1]) - (nums[i] * (n - i - 1));
    }

    return result;
};