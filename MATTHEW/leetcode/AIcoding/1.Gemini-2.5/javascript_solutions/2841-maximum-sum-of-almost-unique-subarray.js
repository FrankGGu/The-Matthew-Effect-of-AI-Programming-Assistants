var maximumSumOfSubarrays = function(nums, m, k) {
    let maxSum = 0;
    let currentSum = 0;
    const freqMap = new Map();

    // Initialize the first window
    for (let i = 0; i < k; i++) {
        currentSum += nums[i];
        freqMap.set(nums[i], (freqMap.get(nums[i]) || 0) + 1);
    }

    // Check the first window
    if (freqMap.size >= m) {
        maxSum = currentSum;
    }

    // Slide the window
    for (let i = k; i < nums.length; i++) {
        // Remove the element leaving the window
        currentSum -= nums[i - k];
        freqMap.set(nums[i - k], freqMap.get(nums[i - k]) - 1);
        if (freqMap.get(nums[i - k]) === 0) {
            freqMap.delete(nums[i - k]);
        }

        // Add the new element entering the window
        currentSum += nums[i];
        freqMap.set(nums[i], (freqMap.get(nums[i]) || 0) + 1);

        // Check the current window
        if (freqMap.size >= m) {
            maxSum = Math.max(maxSum, currentSum);
        }
    }

    return maxSum;
};