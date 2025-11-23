function maximumAlternatingSubarraySum(nums) {
    let maxSum = 0, currentSum = 0, n = nums.length;

    for (let i = 0; i < n; i++) {
        currentSum += nums[i];
        if (i > 0 && nums[i] < nums[i - 1]) {
            currentSum = 0;
        } else if (i > 0 && nums[i] > nums[i - 1]) {
            maxSum = Math.max(maxSum, currentSum);
        }
    }

    return maxSum;
}