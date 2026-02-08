int minimumWhiteTiles(char* floor, int numCarpets, int carpetLen) {
    int n = strlen(floor);
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    prefix[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + (floor[i] == '1');
    }

    int** dp = (int**)malloc((numCarpets + 1) * sizeof(int*));
    for (int i = 0; i <= numCarpets; i++) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= n; i++) {
        dp[0][i] = prefix[i];
    }

    for (int i = 1; i <= numCarpets; i++) {
        for (int j = 1; j <= n; j++) {
            int skip = dp[i][j - 1] + (floor[j - 1] == '1');
            int cover = dp[i - 1][(j - carpetLen > 0) ? (j - carpetLen) : 0];
            dp[i][j] = (skip < cover) ? skip : cover;
        }
    }

    int result = dp[numCarpets][n];

    for (int i = 0; i <= numCarpets; i++) {
        free(dp[i]);
    }
    free(dp);
    free(prefix);

    return result;
}