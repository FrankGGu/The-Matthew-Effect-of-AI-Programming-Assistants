var maxScore = function(cardPoints, k) {
    let n = cardPoints.length;
    let totalSum = 0;
    for (let i = 0; i < n; i++) {
        totalSum += cardPoints[i];
    }

    if (k === n) {
        return totalSum;
    }

    let windowSize = n - k;
    let windowSum = 0;
    for (let i = 0; i < windowSize; i++) {
        windowSum += cardPoints[i];
    }

    let minWindowSum = windowSum;
    for (let i = windowSize; i < n; i++) {
        windowSum += cardPoints[i] - cardPoints[i - windowSize];
        minWindowSum = Math.min(minWindowSum, windowSum);
    }

    return totalSum - minWindowSum;
};