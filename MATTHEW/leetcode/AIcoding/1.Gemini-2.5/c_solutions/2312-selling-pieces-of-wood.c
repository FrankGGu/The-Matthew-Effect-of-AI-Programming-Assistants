#include <stdlib.h>
#include <string.h>

#define MAX_DIM 201

long long dp[MAX_DIM][MAX_DIM];
long long price_map[MAX_DIM][MAX_DIM];

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long sellingWood(int m, int n, int** prices, int pricesSize, int* pricesColSize) {
    memset(dp, 0, sizeof(dp));
    memset(price_map, 0, sizeof(price_map));

    for (int i = 0; i < pricesSize; ++i) {
        int h = prices[i][0];
        int w = prices[i][1];
        long long price = prices[i][2];
        price_map[h][w] = max(price_map[h][w], price);
    }

    for (int i = 1; i <= m; ++i) {
        for (int j = 1; j <= n; ++j) {
            dp[i][j] = price_map[i][j];

            for (int k = 1; k < i; ++k) {
                dp[i][j] = max(dp[i][j], dp[k][j] + dp[i - k][j]);
            }

            for (int k = 1; k < j; ++k) {
                dp[i][j] = max(dp[i][j], dp[i][k] + dp[i][j - k]);
            }
        }
    }

    return dp[m][n];
}