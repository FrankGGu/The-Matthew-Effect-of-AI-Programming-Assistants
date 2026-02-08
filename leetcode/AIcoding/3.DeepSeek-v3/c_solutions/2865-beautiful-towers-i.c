long long maximumSumOfHeights(int* maxHeights, int maxHeightsSize) {
    long long res = 0;
    for (int i = 0; i < maxHeightsSize; i++) {
        long long sum = maxHeights[i];
        int cur = maxHeights[i];
        for (int j = i - 1; j >= 0; j--) {
            cur = (cur < maxHeights[j]) ? cur : maxHeights[j];
            sum += cur;
        }
        cur = maxHeights[i];
        for (int j = i + 1; j < maxHeightsSize; j++) {
            cur = (cur < maxHeights[j]) ? cur : maxHeights[j];
            sum += cur;
        }
        if (sum > res) res = sum;
    }
    return res;
}