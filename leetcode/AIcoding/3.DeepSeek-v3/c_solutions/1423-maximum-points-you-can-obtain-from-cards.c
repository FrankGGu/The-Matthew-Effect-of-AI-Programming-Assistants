int maxScore(int* cardPoints, int cardPointsSize, int k) {
    int totalSum = 0;
    for (int i = 0; i < cardPointsSize; i++) {
        totalSum += cardPoints[i];
    }

    if (k == cardPointsSize) {
        return totalSum;
    }

    int windowSize = cardPointsSize - k;
    int windowSum = 0;
    for (int i = 0; i < windowSize; i++) {
        windowSum += cardPoints[i];
    }

    int minWindowSum = windowSum;
    for (int i = windowSize; i < cardPointsSize; i++) {
        windowSum += cardPoints[i] - cardPoints[i - windowSize];
        if (windowSum < minWindowSum) {
            minWindowSum = windowSum;
        }
    }

    return totalSum - minWindowSum;
}