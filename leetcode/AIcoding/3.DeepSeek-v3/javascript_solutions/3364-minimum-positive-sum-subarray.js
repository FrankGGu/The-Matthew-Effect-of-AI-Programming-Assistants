var minSubArray = function(nums) {
    let minSum = Infinity;
    let currentSum = 0;
    for (let num of nums) {
        currentSum += num;
        if (currentSum > 0) {
            currentSum = 0;
        } else if (currentSum < minSum) {
            minSum = currentSum;
        }
    }
    return minSum === Infinity ? 0 : minSum;
};