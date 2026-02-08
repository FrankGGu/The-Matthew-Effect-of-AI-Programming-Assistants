int waysToCutPizza(char **pizza, int pizzaSize, int *pizzaColSize, int k) {
    int mod = 1e9 + 7;
    int rows = pizzaSize, cols = *pizzaColSize;
    int **prefix = malloc((rows + 1) * sizeof(int *));
    for (int i = 0; i <= rows; i++) {
        prefix[i] = malloc((cols + 1) * sizeof(int));
        for (int j = 0; j <= cols; j++) {
            prefix[i][j] = 0;
        }
    }

    for (int i = rows - 1; i >= 0; i--) {
        for (int j = cols - 1; j >= 0; j--) {
            prefix[i][j] = (pizza[i][j] == 'A') + prefix[i + 1][j] + prefix[i][j + 1] - prefix[i + 1][j + 1];
        }
    }

    int ***dp = malloc((k + 1) * sizeof(int **));
    for (int i = 0; i <= k; i++) {
        dp[i] = malloc(rows * sizeof(int *));
        for (int j = 0; j < rows; j++) {
            dp[i][j] = malloc(cols * sizeof(int));
            for (int l = 0; l < cols; l++) {
                dp[i][j][l] = 0;
            }
        }
    }

    dp[0][0][0] = 1;

    for (int cut = 1; cut <= k; cut++) {
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (prefix[i][j] > 0) {
                    for (int newRow = i + 1; newRow < rows; newRow++) {
                        if (prefix[i][j] > 0) {
                            dp[cut][newRow][j] = (dp[cut][newRow][j] + dp[cut - 1][i][j]) % mod;
                        }
                    }
                    for (int newCol = j + 1; newCol < cols; newCol++) {
                        if (prefix[i][j] > 0) {
                            dp[cut][i][newCol] = (dp[cut][i][newCol] + dp[cut - 1][i][j]) % mod;
                        }
                    }
                }
            }
        }
    }

    int result = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            result = (result + dp[k - 1][i][j]) % mod;
        }
    }

    for (int i = 0; i <= k; i++) {
        for (int j = 0; j < rows; j++) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);

    for (int i = 0; i <= rows; i++) {
        free(prefix[i]);
    }
    free(prefix);

    return result;
}