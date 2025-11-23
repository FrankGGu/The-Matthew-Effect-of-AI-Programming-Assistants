var minMaxSum = function(nums, k) {
    nums.sort((a, b) => a - b);
    let minSum = 0, maxSum = 0;

    for (let i = 0; i < k; i++) {
        minSum += nums[i];
    }

    for (let i = nums.length - 1; i >= nums.length - k; i--) {
        maxSum += nums[i];
    }

    return [minSum, maxSum];
};