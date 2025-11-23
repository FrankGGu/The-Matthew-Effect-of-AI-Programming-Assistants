#include <stdlib.h>

int minRefuelStops(int target, int startFuel, int* stations, int stationsSize) {
    int* dp = (int*)malloc((stationsSize + 1) * sizeof(int));
    for (int i = 0; i <= stationsSize; i++) {
        dp[i] = -1;
    }
    dp[0] = startFuel;

    for (int i = 0; i < stationsSize; i++) {
        for (int j = i; j >= 0; j--) {
            if (dp[j] >= stations[i]) {
                dp[j + 1] = fmax(dp[j + 1], dp[j] + stations[i]);
            }
        }
    }

    for (int i = 0; i <= stationsSize; i++) {
        if (dp[i] >= target) {
            free(dp);
            return i;
        }
    }

    free(dp);
    return -1;
}