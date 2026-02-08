#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    const int *ia = (const int *)a;
    const int *ib = (const int *)b;
    return ia[1] - ib[1];
}

long long maxTaxiEarnings(int n, int** rides, int ridesSize, int* ridesColSize) {
    qsort(rides, ridesSize, sizeof(rides[0]), compare);

    long long dp[ridesSize + 1];
    dp[0] = 0;

    for (int i = 1; i <= ridesSize; i++) {
        dp[i] = dp[i - 1];
        int start = rides[i - 1][0];
        int end = rides[i - 1][1];
        int tip = rides[i - 1][2];
        long long current_earn = end - start + tip;

        int low = 0, high = i - 1;
        int prev_ride_index = 0;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (rides[mid][1] <= start) {
                prev_ride_index = mid + 1;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        dp[i] = (dp[i] > dp[prev_ride_index] + current_earn) ? dp[i] : (dp[prev_ride_index] + current_earn);
    }

    return dp[ridesSize];
}