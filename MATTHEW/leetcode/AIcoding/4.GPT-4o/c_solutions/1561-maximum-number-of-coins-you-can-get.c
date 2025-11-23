int maxCoins(int* piles, int pilesSize) {
    qsort(piles, pilesSize, sizeof(int), cmp);
    int maxCoins = 0;
    for (int i = pilesSize / 3; i < pilesSize / 3 * 2; i++) {
        maxCoins += piles[i];
    }
    return maxCoins;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}