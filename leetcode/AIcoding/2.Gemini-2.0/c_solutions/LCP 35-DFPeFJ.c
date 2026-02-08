#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int solve(int* stations, int stationsSize, int target, int startFuel) {
    int dp[stationsSize + 1];
    for (int i = 0; i <= stationsSize; i++) {
        dp[i] = -1;
    }
    dp[0] = startFuel;

    for (int i = 0; i < stationsSize; i++) {
        for (int j = i; j >= 0; j--) {
            if (dp[j] >= stations[i]) {
                dp[j + 1] = max(dp[j + 1], dp[j] - stations[i]);
            }
        }
    }

    for (int i = 0; i <= stationsSize; i++) {
        if (dp[i] >= target) {
            return i;
        }
    }

    return -1;
}