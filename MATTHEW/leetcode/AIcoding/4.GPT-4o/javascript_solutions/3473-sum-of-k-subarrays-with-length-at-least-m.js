var maxSum = function(nums, k, m) {
    const n = nums.length;
    let maxSum = -Infinity;
    let currentSum = 0;
    let prefixSum = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    let minPrefix = 0;

    for (let i = m; i <= n; i++) {
        currentSum = prefixSum[i] - prefixSum[i - m];
        maxSum = Math.max(maxSum, currentSum + minPrefix);
        minPrefix = Math.min(minPrefix, prefixSum[i - m + 1]);
    }

    return maxSum;
};