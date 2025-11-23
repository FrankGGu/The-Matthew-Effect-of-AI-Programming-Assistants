var maximumSubarraySum = function(nums, k) {
    let prefixSum = 0;
    const prefixSumMap = new Map();
    prefixSumMap.set(0, -1);
    let maxSum = -Infinity;

    for (let i = 0; i < nums.length; i++) {
        prefixSum += nums[i];

        if (prefixSumMap.has(prefixSum - k)) {
            const startIndex = prefixSumMap.get(prefixSum - k);
            const currentSum = prefixSum - (prefixSumMap.get(prefixSum - k) === -1 ? 0 : prefixSumMap.get(prefixSum - k));
            if (currentSum > maxSum) {
                maxSum = currentSum;
            }
        }

        if (!prefixSumMap.has(prefixSum) {
            prefixSumMap.set(prefixSum, i);
        } else {
            if (i < prefixSumMap.get(prefixSum)) {
                prefixSumMap.set(prefixSum, i);
            }
        }
    }

    return maxSum === -Infinity ? 0 : maxSum;
};