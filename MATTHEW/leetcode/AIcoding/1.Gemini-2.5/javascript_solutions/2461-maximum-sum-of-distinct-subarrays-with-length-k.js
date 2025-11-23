var maximumSubarraySum = function(nums, k) {
    let maxSum = 0;
    let currentSum = 0;
    const freqMap = new Map();

    for (let i = 0; i < nums.length; i++) {
        currentSum += nums[i];
        freqMap.set(nums[i], (freqMap.get(nums[i]) || 0) + 1);

        if (i >= k) {
            const leftElement = nums[i - k];
            currentSum -= leftElement;
            freqMap.set(leftElement, freqMap.get(leftElement) - 1);
            if (freqMap.get(leftElement) === 0) {
                freqMap.delete(leftElement);
            }
        }

        if (i >= k - 1) {
            if (freqMap.size === k) {
                maxSum = Math.max(maxSum, currentSum);
            }
        }
    }

    return maxSum;
};