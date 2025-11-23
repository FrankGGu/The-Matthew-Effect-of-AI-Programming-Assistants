var maximumSubarraySumWithLengthDivisibleByK = function(nums, k) {
    let n = nums.length;
    let prefixSum = new Array(k).fill(Infinity);
    prefixSum[0] = 0;
    let currentSum = 0;
    let maxSum = -Infinity;

    for (let i = 0; i < n; i++) {
        currentSum += nums[i];
        let remainder = currentSum % k;
        maxSum = Math.max(maxSum, currentSum - prefixSum[remainder]);
        prefixSum[remainder] = Math.min(prefixSum[remainder], currentSum);
    }

    return maxSum === -Infinity ? 0 : maxSum;
};