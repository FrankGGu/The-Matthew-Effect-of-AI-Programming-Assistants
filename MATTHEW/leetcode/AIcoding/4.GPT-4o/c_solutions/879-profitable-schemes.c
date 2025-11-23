#define MOD 1000000007

int profitableSchemes(int G, int P, int* group, int groupSize, int* profit, int profitSize) {
    int dp[G + 1][P + 1];
    for (int i = 0; i <= G; i++) {
        for (int j = 0; j <= P; j++) {
            dp[i][j] = (i == 0 && j == 0) ? 1 : 0;
        }
    }

    for (int k = 0; k < profitSize; k++) {
        int g = group[k];
        int p = profit[k];
        for (int i = G; i >= g; i--) {
            for (int j = P; j >= 0; j--) {
                dp[i][j] = (dp[i][j] + dp[i - g][j > p ? j - p : 0]) % MOD;
            }
        }
    }

    long long result = 0;
    for (int i = 0; i <= G; i++) {
        for (int j = P; j <= P; j++) {
            result = (result + dp[i][j]) % MOD;
        }
    }

    return (int)result;
}