var maxScore = function(cardPoints, k) {
    const n = cardPoints.length;
    let total = 0;

    for (let i = 0; i < k; i++) {
        total += cardPoints[i];
    }

    let maxPoints = total;

    for (let i = 0; i < k; i++) {
        total += cardPoints[n - 1 - i] - cardPoints[k - 1 - i];
        maxPoints = Math.max(maxPoints, total);
    }

    return maxPoints;
};