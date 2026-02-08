int maxCount(int* prices, int pricesSize, int k) {
    int count = 0, sum = 0;
    qsort(prices, pricesSize, sizeof(int), cmp);
    for (int i = 0; i < pricesSize; i++) {
        if (sum + prices[i] <= k) {
            sum += prices[i];
            count++;
        } else {
            break;
        }
    }
    return count;
}

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}