int maxCoins(int* bags, int bagsSize, int k) {
    int maxCoins = 0;
    int currentSum = 0;

    for (int i = 0; i < k; i++) {
        currentSum += bags[i];
    }

    maxCoins = currentSum;

    for (int i = k; i < bagsSize; i++) {
        currentSum += bags[i] - bags[i - k];
        if (currentSum > maxCoins) {
            maxCoins = currentSum;
        }
    }

    return maxCoins;
}