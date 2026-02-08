int maxScoreSightseeingPair(int* values, int valuesSize) {
    int maxScore = 0, maxI = values[0];
    for (int j = 1; j < valuesSize; j++) {
        maxScore = fmax(maxScore, maxI + values[j] - j);
        maxI = fmax(maxI, values[j] + j);
    }
    return maxScore;
}