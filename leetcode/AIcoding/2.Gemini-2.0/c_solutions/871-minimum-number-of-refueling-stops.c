#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minRefuelStops(int target, int startFuel, int** stations, int stationsSize, int* stationsColSize) {
    int n = stationsSize;
    long long dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = 0;
    }
    dp[0] = startFuel;
    for (int i = 0; i < n; i++) {
        for (int j = i; j >= 0; j--) {
            if (dp[j] >= stations[i][0]) {
                dp[j + 1] = (dp[j + 1] > dp[j] + stations[i][1]) ? dp[j + 1] : (dp[j] + stations[i][1]);
            }
        }
    }
    for (int i = 0; i <= n; i++) {
        if (dp[i] >= target) {
            return i;
        }
    }
    return -1;
}