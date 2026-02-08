int minimumLines(int** stockPrices, int stockPricesSize, int* stockPricesColSize) {
    if (stockPricesSize < 2) return 0;

    qsort(stockPrices, stockPricesSize, sizeof(int*), cmp);

    int lines = 0;
    long long prevX = stockPrices[0][0], prevY = stockPrices[0][1];
    long long currX, currY;

    for (int i = 1; i < stockPricesSize; i++) {
        currX = stockPrices[i][0];
        currY = stockPrices[i][1];

        if (lines == 0 || (currY - prevY) * (currX - prevX) != (currY - prevY) * (currX - prevX)) {
            lines++;
        }

        prevX = currX;
        prevY = currY;
    }

    return lines - 1;
}

int cmp(const void *a, const void *b) {
    return (*(int**)a)[0] - (*(int**)b)[0];
}