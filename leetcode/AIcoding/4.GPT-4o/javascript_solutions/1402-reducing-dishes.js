var maxSatisfaction = function(satisfaction) {
    satisfaction.sort((a, b) => a - b);
    let maxSum = 0, currSum = 0, n = satisfaction.length;

    for (let i = n - 1; i >= 0; i--) {
        currSum += satisfaction[i];
        if (currSum + maxSum > maxSum) {
            maxSum += currSum;
        } else {
            break;
        }
    }

    return maxSum;
};