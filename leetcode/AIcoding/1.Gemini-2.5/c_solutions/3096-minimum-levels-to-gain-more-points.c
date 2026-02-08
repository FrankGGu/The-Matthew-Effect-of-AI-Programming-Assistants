int minimumLevels(int* possibleScores, int possibleScoresSize) {
    long long totalSum = 0;
    for (int i = 0; i < possibleScoresSize; i++) {
        totalSum += possibleScores[i];
    }

    long long currentPrefixSum = 0;
    for (int k = 1; k < possibleScoresSize; k++) {
        currentPrefixSum += possibleScores[k - 1];
        if (currentPrefixSum > (totalSum - currentPrefixSum)) {
            return k;
        }
    }
    return -1;
}