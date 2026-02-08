long long maximumSumOfHeights(int* maxHeights, int maxHeightsSize) {
    long long res = 0;
    for (int i = 0; i < maxHeightsSize; i++) {
        long long sum = maxHeights[i];
        int prev = maxHeights[i];
        for (int j = i - 1; j >= 0; j--) {
            prev = (prev < maxHeights[j]) ? prev : maxHeights[j];
            sum += prev;
        }
        prev = maxHeights[i];
        for (int j = i + 1; j < maxHeightsSize; j++) {
            prev = (prev < maxHeights[j]) ? prev : maxHeights[j];
            sum += prev;
        }
        if (sum > res) res = sum;
    }
    return res;
}