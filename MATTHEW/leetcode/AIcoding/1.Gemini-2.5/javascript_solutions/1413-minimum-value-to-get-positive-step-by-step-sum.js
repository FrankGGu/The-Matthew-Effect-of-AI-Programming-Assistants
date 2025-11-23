var minStartValue = function(nums) {
    let currentSum = 0;
    let minSumSoFar = 0;
    for (let i = 0; i < nums.length; i++) {
        currentSum += nums[i];
        minSumSoFar = Math.min(minSumSoFar, currentSum);
    }
    return 1 - minSumSoFar;