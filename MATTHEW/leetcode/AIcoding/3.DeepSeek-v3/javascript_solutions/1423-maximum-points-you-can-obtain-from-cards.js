var maxScore = function(cardPoints, k) {
    let totalSum = 0;
    for (let point of cardPoints) {
        totalSum += point;
    }

    if (k === cardPoints.length) {
        return totalSum;
    }

    let windowSize = cardPoints.length - k;
    let windowSum = 0;
    for (let i = 0; i < windowSize; i++) {
        windowSum += cardPoints[i];
    }

    let minWindowSum = windowSum;
    for (let i = windowSize; i < cardPoints.length; i++) {
        windowSum += cardPoints[i] - cardPoints[i - windowSize];
        minWindowSum = Math.min(minWindowSum, windowSum);
    }

    return totalSum - minWindowSum;
};