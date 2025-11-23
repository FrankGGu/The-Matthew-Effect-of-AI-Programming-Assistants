int compare(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

int maxCoins(int* piles, int pilesSize) {
    qsort(piles, pilesSize, sizeof(int), compare);
    int ans = 0;
    int i = 1;
    int count = 0;
    while (count < pilesSize / 3) {
        ans += piles[i];
        i += 2;
        count++;
    }
    return ans;
}