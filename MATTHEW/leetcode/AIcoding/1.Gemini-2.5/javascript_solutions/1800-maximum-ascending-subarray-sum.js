var maxAscendingSum = function(nums) {
    let maxSum = 0;
    let currentSum = 0;

    for (let i = 0; i < nums.length; i++) {
        if (i === 0 || nums[i] > nums[i - 1]) {
            currentSum += nums[i];
        } else {
            currentSum = nums[i];
        }
        maxSum = Math.max(maxSum, currentSum);
    }

    return maxSum;
};