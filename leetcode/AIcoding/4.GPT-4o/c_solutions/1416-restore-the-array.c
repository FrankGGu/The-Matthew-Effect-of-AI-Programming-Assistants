int countRoutes(char *locations, int start, int finish, int fuel, int **dp, int locationsSize) {
    if (fuel < 0) return 0;
    if (dp[start][fuel] != -1) return dp[start][fuel];
    int count = (start == finish) ? 1 : 0;
    for (int next = 0; next < locationsSize; next++) {
        if (next != start) {
            count = (count + countRoutes(locations, next, finish, fuel - abs(locations[next] - locations[start]), dp, locationsSize)) % 1000000007;
        }
    }
    return dp[start][fuel] = count;
}

int countRoutes(char * locations, int start, int finish, int fuel) {
    int locationsSize = strlen(locations);
    int **dp = (int **)malloc(locationsSize * sizeof(int *));
    for (int i = 0; i < locationsSize; i++) {
        dp[i] = (int *)malloc((fuel + 1) * sizeof(int));
        for (int j = 0; j <= fuel; j++) {
            dp[i][j] = -1;
        }
    }
    int result = countRoutes(locations, start, finish, fuel, dp, locationsSize);
    for (int i = 0; i < locationsSize; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}