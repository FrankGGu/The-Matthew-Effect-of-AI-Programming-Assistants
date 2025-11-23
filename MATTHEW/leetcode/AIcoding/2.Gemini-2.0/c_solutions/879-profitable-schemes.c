#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int profitableSchemes(int n, int minProfit, int* group, int groupSize, int* profit, int profitSize) {
    int mod = 1000000007;
    int dp[groupSize + 1][n + 1][minProfit + 1];

    for (int i = 0; i <= groupSize; i++) {
        for (int j = 0; j <= n; j++) {
            for (int k = 0; k <= minProfit; k++) {
                dp[i][j][k] = 0;
            }
        }
    }

    dp[0][0][0] = 1;

    for (int i = 1; i <= groupSize; i++) {
        for (int j = 0; j <= n; j++) {
            for (int k = 0; k <= minProfit; k++) {
                dp[i][j][k] = dp[i - 1][j][k];
                if (j >= group[i - 1]) {
                    int newProfit = k + profit[i - 1];
                    if (newProfit > minProfit) {
                        newProfit = minProfit;
                    }
                    dp[i][j][k] = (dp[i][j][k] + dp[i - 1][j - group[i - 1]][k - profit[i - 1] > 0 ? 0 : k]) % mod;
                }
            }
        }
    }

    int total = 0;
    for (int j = 0; j <= n; j++) {
        total = (total + dp[groupSize][j][minProfit]) % mod;
    }

    return total;
}