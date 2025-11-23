var waysToSplitArray = function(nums) {
    let n = nums.length;
    let totalSum = 0;
    for (let num of nums) {
        totalSum += num;
    }
    let count = 0;
    let currentSum = 0;
    for (let i = 0; i < n - 1; i++) {
        currentSum += nums[i];
        if (currentSum >= totalSum - currentSum) {
            count++;
        }
    }
    return count;
};