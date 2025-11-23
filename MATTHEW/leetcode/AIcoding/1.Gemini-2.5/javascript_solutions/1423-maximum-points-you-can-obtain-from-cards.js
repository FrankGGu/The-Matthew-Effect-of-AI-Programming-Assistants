var maxScore = function(cardPoints, k) {
    let n = cardPoints.length;
    let currentSum = 0;

    for (let i = 0; i < k; i++) {
        currentSum += cardPoints[i];
    }

    let maxSum = currentSum;

    for (let i = 1; i <= k; i++) {
        currentSum = currentSum - cardPoints[k - i] + cardPoints[n - i];
        maxSum = Math.max(maxSum, currentSum);
    }

    return maxSum;
};