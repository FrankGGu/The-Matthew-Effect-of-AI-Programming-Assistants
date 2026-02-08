var maxSatisfaction = function(satisfaction) {
    satisfaction.sort((a, b) => a - b);
    let maxSum = 0;
    let total = 0;
    let currentSum = 0;

    for (let i = satisfaction.length - 1; i >= 0; i--) {
        total += satisfaction[i];
        currentSum += total;
        if (currentSum > maxSum) {
            maxSum = currentSum;
        } else {
            break;
        }
    }

    return maxSum;
};