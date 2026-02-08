var minPairSum = function(nums) {
    nums.sort((a, b) => a - b);
    let maxPairSum = 0;
    for (let i = 0; i < nums.length / 2; i++) {
        maxPairSum = Math.max(maxPairSum, nums[i] + nums[nums.length - 1 - i]);
    }
    return maxPairSum;
};