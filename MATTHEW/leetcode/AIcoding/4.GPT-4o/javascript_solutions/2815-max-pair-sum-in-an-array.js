var maxSum = function(nums) {
    let maxPairSum = 0;
    const n = nums.length;
    nums.sort((a, b) => a - b);
    for (let i = 0; i < n / 2; i++) {
        maxPairSum = Math.max(maxPairSum, nums[i] + nums[n - 1 - i]);
    }
    return maxPairSum;
};