long long supplyWagons(int* supplyWagons, int supplyWagonsSize, int k) {
    long long totalSum = 0;
    for (int i = 0; i < supplyWagonsSize; i++) {
        totalSum += supplyWagons[i];
    }
    return totalSum;
}