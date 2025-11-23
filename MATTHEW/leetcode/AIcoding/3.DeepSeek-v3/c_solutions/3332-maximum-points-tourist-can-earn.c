int maxScore(int* values, int valuesSize, int k) {
    int total = 0;
    for (int i = 0; i < valuesSize; i++) {
        total += values[i];
    }

    if (k == valuesSize) {
        return total;
    }

    int windowSize = valuesSize - k;
    int windowSum = 0;
    for (int i = 0; i < windowSize; i++) {
        windowSum += values[i];
    }

    int minWindowSum = windowSum;
    for (int i = windowSize; i < valuesSize; i++) {
        windowSum += values[i] - values[i - windowSize];
        if (windowSum < minWindowSum) {
            minWindowSum = windowSum;
        }
    }

    return total - minWindowSum;
}