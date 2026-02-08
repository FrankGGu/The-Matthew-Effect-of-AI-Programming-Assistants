int profitableSchemes(int n, int minProfit, int* group, int groupSize, int* profit, int profitSize) {
    int MOD = 1000000007;
    int dp[101][101] = {0};
    dp[0][0] = 1;

    for (int k = 0; k < groupSize; k++) {
        int g = group[k];
        int p = profit[k];
        for (int i = n; i >= 0; i--) {
            for (int j = minProfit; j >= 0; j--) {
                if (i + g <= n) {
                    int newProfit = j + p;
                    if (newProfit > minProfit) {
                        newProfit = minProfit;
                    }
                    dp[i + g][newProfit] = (dp[i + g][newProfit] + dp[i][j]) % MOD;
                }
            }
        }
    }

    int result = 0;
    for (int i = 0; i <= n; i++) {
        result = (result + dp[i][minProfit]) % MOD;
    }
    return result;
}