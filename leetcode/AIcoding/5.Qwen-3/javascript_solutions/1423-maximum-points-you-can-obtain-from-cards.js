function maxScore(cardPoints, k) {
    const n = cardPoints.length;
    let total = 0;
    for (let i = 0; i < n; i++) {
        total += cardPoints[i];
    }

    let windowSize = n - k;
    let currentWindow = 0;
    for (let i = 0; i < windowSize; i++) {
        currentWindow += cardPoints[i];
    }

    let minWindow = currentWindow;
    for (let i = windowSize; i < n; i++) {
        currentWindow += cardPoints[i] - cardPoints[i - windowSize];
        minWindow = Math.min(minWindow, currentWindow);
    }

    return total - minWindow;
}