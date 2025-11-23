int getMaxGridHappiness(int m, int n, int introvertsCount, int extrovertsCount) {
    int dp[51][51][21][21][4] = {0};
    int i, j, k, l, t, r, c, mask;

    for (i = 0; i < (1 << (m * n)); i++) {
        r = 0; c = 0; t = 0; k = 0; l = 0;
        int introverts = 0, extroverts = 0, happiness = 0;

        for (j = 0; j < m; j++) {
            for (k = 0; k < n; k++) {
                mask = 1 << (j * n + k);
                if (i & mask) {
                    if (l == 0) {
                        if (extrovertsCount > 0) {
                            extroverts++;
                            happiness += 120;
                            extrovertsCount--;
                        } else if (introvertsCount > 0) {
                            introverts++;
                            happiness += 40;
                            introvertsCount--;
                        }
                    }
                    if (j > 0 && (i & (1 << ((j - 1) * n + k)))) {
                        happiness -= 30;
                    }
                    if (k > 0 && (i & (1 << (j * n + (k - 1))))) {
                        happiness -= 30;
                    }
                    if (j < m - 1 && (i & (1 << ((j + 1) * n + k)))) {
                        happiness -= 30;
                    }
                    if (k < n - 1 && (i & (1 << (j * n + (k + 1))))) {
                        happiness -= 30;
                    }
                }
            }
        }

        if (introverts + extroverts > 0) {
            dp[m][n][introverts][extroverts][0] = 
                dp[m][n][introverts][extroverts][0] > happiness ? 
                dp[m][n][introverts][extroverts][0] : happiness;
        }
    }

    return dp[m][n][introvertsCount][extrovertsCount][0];
}