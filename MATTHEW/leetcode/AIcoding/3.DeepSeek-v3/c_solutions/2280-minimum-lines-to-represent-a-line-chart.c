/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int cmp(const void* a, const void* b) {
    long long* pa = (long long*)a;
    long long* pb = (long long*)b;
    if (pa[0] != pb[0]) {
        return pa[0] > pb[0] ? 1 : -1;
    }
    return pa[1] > pb[1] ? 1 : -1;
}

int minimumLines(int** stockPrices, int stockPricesSize, int* stockPricesColSize) {
    if (stockPricesSize == 1) return 0;
    if (stockPricesSize == 2) return 1;

    qsort(stockPrices, stockPricesSize, sizeof(int*), cmp);

    int lines = 1;
    for (int i = 2; i < stockPricesSize; i++) {
        long long x1 = stockPrices[i-2][0], y1 = stockPrices[i-2][1];
        long long x2 = stockPrices[i-1][0], y2 = stockPrices[i-1][1];
        long long x3 = stockPrices[i][0], y3 = stockPrices[i][1];

        long long diff1 = (y2 - y1) * (x3 - x2);
        long long diff2 = (y3 - y2) * (x2 - x1);

        if (diff1 != diff2) {
            lines++;
        }
    }

    return lines;
}