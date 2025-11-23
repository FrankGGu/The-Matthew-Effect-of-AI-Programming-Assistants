int minCount(int* coins, int coinsSize) {
    int totalOperations = 0;
    for (int i = 0; i < coinsSize; i++) {
        totalOperations += (coins[i] + 1) / 2;
    }
    return totalOperations;
}