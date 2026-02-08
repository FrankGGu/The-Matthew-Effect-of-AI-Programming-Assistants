var maximumSubarraySum = function(nums, k) {
    let maxSum = 0;
    let currentSum = 0;
    const frequencyMap = new Map();
    let left = 0;

    for (let right = 0; right < nums.length; right++) {
        currentSum += nums[right];
        frequencyMap.set(nums[right], (frequencyMap.get(nums[right]) || 0) + 1);

        if (right - left + 1 === k) {
            if (frequencyMap.size === k) {
                maxSum = Math.max(maxSum, currentSum);
            }
            currentSum -= nums[left];
            const leftCount = frequencyMap.get(nums[left]);
            if (leftCount === 1) {
                frequencyMap.delete(nums[left]);
            } else {
                frequencyMap.set(nums[left], leftCount - 1);
            }
            left++;
        }
    }

    return maxSum;
};