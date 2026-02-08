var maxSumMinSumSubarrays = function(nums, k) {
    let maxSum = -Infinity;
    let minSum = Infinity;
    let currentSum = 0;
    let windowStart = 0;
    let n = nums.length;

    for (let windowEnd = 0; windowEnd < n; windowEnd++) {
        currentSum += nums[windowEnd];

        if (windowEnd >= k - 1) {
            maxSum = Math.max(maxSum, currentSum);
            minSum = Math.min(minSum, currentSum);
            currentSum -= nums[windowStart];
            windowStart++;
        }
    }

    return [maxSum, minSum];
};