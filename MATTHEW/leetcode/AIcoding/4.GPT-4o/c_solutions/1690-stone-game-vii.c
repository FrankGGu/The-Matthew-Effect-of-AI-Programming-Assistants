int stoneGameVII(int* stones, int stonesSize) {
    int prefixSum = 0, totalSum = 0;
    for (int i = 0; i < stonesSize; i++) {
        totalSum += stones[i];
    }
    int maxScore = 0;
    for (int i = 0; i < stonesSize - 1; i++) {
        prefixSum += stones[i];
        int currentScore = totalSum - prefixSum;
        maxScore = (maxScore > currentScore) ? maxScore : currentScore;
        totalSum -= stones[i + 1];
    }
    return maxScore;
}