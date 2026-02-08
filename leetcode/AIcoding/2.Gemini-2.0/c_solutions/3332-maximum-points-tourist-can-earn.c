#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maxPoints(int* attractions, int attractionsSize) {
    int dp[attractionsSize];

    if (attractionsSize == 0) {
        return 0;
    }

    dp[0] = attractions[0];

    if (attractionsSize == 1) {
        return dp[0];
    }

    dp[1] = max(attractions[0], attractions[1]);

    for (int i = 2; i < attractionsSize; i++) {
        dp[i] = max(dp[i - 1], dp[i - 2] + attractions[i]);
    }

    return dp[attractionsSize - 1];
}