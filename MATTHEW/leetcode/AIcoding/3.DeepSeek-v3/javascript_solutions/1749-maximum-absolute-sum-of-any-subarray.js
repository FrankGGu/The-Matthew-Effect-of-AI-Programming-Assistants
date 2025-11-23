var maxAbsoluteSum = function(nums) {
    let maxSum = 0, minSum = 0, currentMax = 0, currentMin = 0;
    for (let num of nums) {
        currentMax = Math.max(num, currentMax + num);
        currentMin = Math.min(num, currentMin + num);
        maxSum = Math.max(maxSum, currentMax);
        minSum = Math.min(minSum, currentMin);
    }
    return Math.max(maxSum, -minSum);
};