var maxSubarraySumCircular = function(nums) {
    let total = 0, maxSum = nums[0], curMax = 0, minSum = nums[0], curMin = 0;
    for (let num of nums) {
        curMax = Math.max(curMax + num, num);
        maxSum = Math.max(maxSum, curMax);
        curMin = Math.min(curMin + num, num);
        minSum = Math.min(minSum, curMin);
        total += num;
    }
    return maxSum > 0 ? Math.max(maxSum, total - minSum) : maxSum;
};