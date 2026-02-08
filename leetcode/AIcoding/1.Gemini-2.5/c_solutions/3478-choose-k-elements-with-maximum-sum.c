int maxScore(int* cardPoints, int cardPointsSize, int k) {
    int n = cardPointsSize;
    int current_sum = 0;

    for (int i = 0; i < k; i++) {
        current_sum += cardPoints[i];
    }

    int max_sum = current_sum;

    for (int i = 1; i <= k; i++) {
        current_sum = current_sum - cardPoints[k - i] + cardPoints[n - i];
        if (current_sum > max_sum) {
            max_sum = current_sum;
        }
    }

    return max_sum;
}