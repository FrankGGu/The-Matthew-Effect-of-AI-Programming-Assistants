#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countRoutes(int* locations, int locationsSize, int start, int finish, int fuel) {
    int MOD = 1000000007;
    int dp[locationsSize][fuel + 1];
    for (int i = 0; i < locationsSize; i++) {
        for (int j = 0; j <= fuel; j++) {
            dp[i][j] = -1;
        }
    }

    int solve(int city, int remainingFuel) {
        if (remainingFuel < 0) {
            return 0;
        }

        if (dp[city][remainingFuel] != -1) {
            return dp[city][remainingFuel];
        }

        int count = (city == finish) ? 1 : 0;

        for (int nextCity = 0; nextCity < locationsSize; nextCity++) {
            if (nextCity != city) {
                int cost = abs(locations[city] - locations[nextCity]);
                count = (count + solve(nextCity, remainingFuel - cost)) % MOD;
            }
        }

        return dp[city][remainingFuel] = count;
    }

    return solve(start, fuel);
}