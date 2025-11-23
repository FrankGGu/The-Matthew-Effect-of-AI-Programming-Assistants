var maxSum = function(nums, m, k) {
    let left = 0;
    let right = 0;
    let currentSum = 0;
    let maxSubarraySum = 0;
    let uniqueCount = 0;
    const frequencyMap = new Map();

    while (right < nums.length) {
        const rightElement = nums[right];

        if (!frequencyMap.has(rightElement)) {
            frequencyMap.set(rightElement, 0);
        }

        frequencyMap.set(rightElement, frequencyMap.get(rightElement) + 1);

        if (frequencyMap.get(rightElement) === 1) {
            uniqueCount++;
        }

        currentSum += rightElement;

        while (right - left + 1 > k) {
            const leftElement = nums[left];
            frequencyMap.set(leftElement, frequencyMap.get(leftElement) - 1);

            if (frequencyMap.get(leftElement) === 0) {
                uniqueCount--;
            }

            currentSum -= leftElement;
            left++;
        }

        if (right - left + 1 === k && uniqueCount >= m) {
            maxSubarraySum = Math.max(maxSubarraySum, currentSum);
        }

        right++;
    }

    return maxSubarraySum;
};