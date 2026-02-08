int maxCoins(int* piles, int pilesSize) {
    qsort(piles, pilesSize, sizeof(int), cmp);
    int total = 0;
    for (int i = pilesSize / 3; i < pilesSize / 3 * 2; i++) {
        total += piles[i];
    }
    return total;
}

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}