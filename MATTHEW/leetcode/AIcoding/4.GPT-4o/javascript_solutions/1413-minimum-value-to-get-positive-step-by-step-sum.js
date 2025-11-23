var minStartValue = function(nums) {
    let minSum = 0, currentSum = 0;
    for (let num of nums) {
        currentSum += num;
        minSum = Math.min(minSum, currentSum);
    }
    return 1 - minSum;
};