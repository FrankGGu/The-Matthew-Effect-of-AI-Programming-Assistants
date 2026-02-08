int maxScore(int* cardPoints, int cardPointsSize, int k) {
    int total = 0, n = cardPointsSize;
    for (int i = 0; i < k; i++) {
        total += cardPoints[i];
    }
    int maxPoints = total;
    for (int i = 0; i < k; i++) {
        total = total - cardPoints[k - 1 - i] + cardPoints[n - 1 - i];
        if (total > maxPoints) {
            maxPoints = total;
        }
    }
    return maxPoints;
}