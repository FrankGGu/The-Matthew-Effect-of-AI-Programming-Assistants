var minPairSum = function(nums) {
    nums.sort((a, b) => a - b);
    let maxSum = 0;
    for (let i = 0; i < nums.length / 2; i++) {
        maxSum = Math.max(maxSum, nums[i] + nums[nums.length - 1 - i]);
    }
    return maxSum;
};