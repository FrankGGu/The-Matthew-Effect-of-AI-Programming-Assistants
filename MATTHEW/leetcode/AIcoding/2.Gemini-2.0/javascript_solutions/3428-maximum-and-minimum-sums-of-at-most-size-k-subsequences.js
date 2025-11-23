var maxMinSum = function(nums, k) {
    const n = nums.length;
    nums.sort((a, b) => a - b);
    let minSum = 0;
    let maxSum = 0;
    for (let i = 0; i < k; i++) {
        minSum += nums[i];
        maxSum += nums[n - 1 - i];
    }
    return [maxSum, minSum];
};