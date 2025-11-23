int missingObservations(int* observations, int observationsSize, int n) {
    int totalSum = n * (n + 1) / 2;
    int currentSum = 0;
    for (int i = 0; i < observationsSize; i++) {
        currentSum += observations[i];
    }
    return totalSum - currentSum;
}