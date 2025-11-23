int countRoutes(int* locations, int locationsSize, int start, int finish, int fuel) {
    int MOD = 1000000007;
    int dp[locationsSize][fuel + 1];

    for (int i = 0; i < locationsSize; i++) {
        for (int j = 0; j <= fuel; j++) {
            dp[i][j] = 0;
        }
    }

    dp[start][fuel] = 1;

    for (int f = fuel; f >= 0; f--) {
        for (int i = 0; i < locationsSize; i++) {
            if (dp[i][f] == 0) continue;

            for (int j = 0; j < locationsSize; j++) {
                if (i == j) continue;

                int cost = abs(locations[i] - locations[j]);
                if (f >= cost) {
                    dp[j][f - cost] = (dp[j][f - cost] + dp[i][f]) % MOD;
                }
            }
        }
    }

    int result = 0;
    for (int f = 0; f <= fuel; f++) {
        result = (result + dp[finish][f]) % MOD;
    }

    return result;
}