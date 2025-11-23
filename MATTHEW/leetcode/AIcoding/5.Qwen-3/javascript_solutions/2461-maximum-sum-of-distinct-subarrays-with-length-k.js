function findMaximumSubarraySum(nums, k) {
    let maxSum = 0;
    let currentSum = 0;
    let seen = new Map();

    for (let i = 0; i < nums.length; i++) {
        if (seen.has(nums[i])) {
            const prevIndex = seen.get(nums[i]);
            if (prevIndex >= i - k + 1) {
                const start = i - k + 1;
                for (let j = prevIndex + 1; j < start; j++) {
                    currentSum -= nums[j];
                }
            }
        }
        currentSum += nums[i];
        seen.set(nums[i], i);
        if (i >= k - 1) {
            maxSum = Math.max(maxSum, currentSum);
        }
    }

    return maxSum;
}