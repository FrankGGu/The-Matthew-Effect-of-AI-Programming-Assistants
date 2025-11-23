int maxScore(int* cardPoints, int cardPointsSize, int k) {
    int total = 0;
    for (int i = 0; i < k; i++) {
        total += cardPoints[i];
    }
    int maxScore = total;
    for (int i = 0; i < k; i++) {
        total = total - cardPoints[k - 1 - i] + cardPoints[cardPointsSize - 1 - i];
        if (total > maxScore) {
            maxScore = total;
        }
    }
    return maxScore;
}