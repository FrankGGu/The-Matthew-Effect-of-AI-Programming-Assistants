int ways(char ** pizza, int pizzaSize, int k){
    int rows = pizzaSize;
    int cols = strlen(pizza[0]);
    int mod = 1e9 + 7;

    int **apples = (int **)malloc((rows + 1) * sizeof(int *));
    for (int i = 0; i <= rows; i++) {
        apples[i] = (int *)calloc(cols + 1, sizeof(int));
    }

    int ***dp = (int ***)malloc(k * sizeof(int **));
    for (int i = 0; i < k; i++) {
        dp[i] = (int **)malloc(rows * sizeof(int *));
        for (int j = 0; j < rows; j++) {
            dp[i][j] = (int *)calloc(cols, sizeof(int));
        }
    }

    for (int i = rows - 1; i >= 0; i--) {
        for (int j = cols - 1; j >= 0; j--) {
            apples[i][j] = (pizza[i][j] == 'A') + apples[i+1][j] + apples[i][j+1] - apples[i+1][j+1];
            dp[0][i][j] = apples[i][j] > 0 ? 1 : 0;
        }
    }

    for (int remain = 1; remain < k; remain++) {
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                for (int next_row = i + 1; next_row < rows; next_row++) {
                    if (apples[i][j] - apples[next_row][j] > 0) {
                        dp[remain][i][j] = (dp[remain][i][j] + dp[remain-1][next_row][j]) % mod;
                    }
                }
                for (int next_col = j + 1; next_col < cols; next_col++) {
                    if (apples[i][j] - apples[i][next_col] > 0) {
                        dp[remain][i][j] = (dp[remain][i][j] + dp[remain-1][i][next_col]) % mod;
                    }
                }
            }
        }
    }

    int result = dp[k-1][0][0];

    for (int i = 0; i <= rows; i++) {
        free(apples[i]);
    }
    free(apples);

    for (int i = 0; i < k; i++) {
        for (int j = 0; j < rows; j++) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);

    return result;
}