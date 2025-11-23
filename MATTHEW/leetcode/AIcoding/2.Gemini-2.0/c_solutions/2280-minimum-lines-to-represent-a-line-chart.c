#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

int minimumLines(int** stockPrices, int stockPricesSize, int* stockPricesColSize) {
    if (stockPricesSize <= 1) return 0;
    if (stockPricesSize == 2) return 1;

    int lines = 1;
    for (int i = 2; i < stockPricesSize; i++) {
        long long x1 = stockPrices[i - 2][0], y1 = stockPrices[i - 2][1];
        long long x2 = stockPrices[i - 1][0], y2 = stockPrices[i - 1][1];
        long long x3 = stockPrices[i][0], y3 = stockPrices[i][1];

        long long dx1 = x2 - x1, dy1 = y2 - y1;
        long long dx2 = x3 - x2, dy2 = y3 - y2;

        if (dx1 * dy2 != dx2 * dy1) {
            lines++;
        }
    }

    return lines;
}