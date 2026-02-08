var minSubsequence = function(nums) {
    nums.sort((a, b) => b - a);
    let sum = nums.reduce((acc, curr) => acc + curr, 0);
    let currentSum = 0;
    let result = [];
    for (let i = 0; i < nums.length; i++) {
        currentSum += nums[i];
        result.push(nums[i]);
        if (currentSum > sum - currentSum) {
            break;
        }
    }
    return result;
};