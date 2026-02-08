var numberOfArrays = function(n, lower, upper, differences) {
    let minSum = 0;
    let maxSum = 0;
    let currentSum = 0;

    for (let diff of differences) {
        currentSum += diff;
        minSum = Math.min(minSum, currentSum);
        maxSum = Math.max(maxSum, currentSum);
    }

    let minStart = lower - minSum;
    let maxStart = upper - maxSum;

    return Math.max(0, maxStart - minStart + 1);
};