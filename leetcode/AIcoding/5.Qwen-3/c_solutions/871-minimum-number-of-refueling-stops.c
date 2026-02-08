#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

int minRefuelStops(int target, int startFuel, int** stations, int stationsSize, int* stationsColSize) {
    int n = stationsSize;
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    dp[0] = startFuel;

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j > 0; j--) {
            if (dp[j - 1] >= stations[i][0]) {
                dp[j] = fmax(dp[j], dp[j - 1] + stations[i][1]);
            }
        }
    }

    for (int i = 0; i <= n; i++) {
        if (dp[i] >= target) {
            free(dp);
            return i;
        }
    }

    free(dp);
    return -1;
}