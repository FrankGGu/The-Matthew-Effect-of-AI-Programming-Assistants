int getMaximumConsecutive(int* coins, int coinsSize) {
    int maxConsecutive = 0;
    qsort(coins, coinsSize, sizeof(int), compare);
    for (int i = 0; i < coinsSize; i++) {
        if (coins[i] > maxConsecutive + 1) break;
        maxConsecutive += coins[i];
    }
    return maxConsecutive + 1;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}