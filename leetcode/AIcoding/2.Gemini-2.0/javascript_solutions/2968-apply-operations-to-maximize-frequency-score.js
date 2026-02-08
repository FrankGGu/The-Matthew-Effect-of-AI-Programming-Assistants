var maxFrequencyScore = function(nums, k) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let left = 0;
    let right = 0;
    let currentCost = 0;
    let maxLen = 0;

    while (right < n) {
        currentCost += (nums[right] - nums[Math.floor((left + right) / 2)]);

        while (currentCost > k) {
             currentCost -= (nums[Math.floor((left + right) / 2)] - nums[left]);
             left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
        right++;
    }

    return maxLen;
};