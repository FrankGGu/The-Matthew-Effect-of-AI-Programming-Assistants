#include <stdlib.h>
#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maxValueOfCoins(int** piles, int pilesSize, int* pilesColSize, int k) {
    int* dp = (int*)malloc((k + 1) * sizeof(int));

    dp[0] = 0;
    for (int i = 1; i <= k; ++i) {
        dp[i] = INT_MIN;
    }

    for (int i = 0; i < pilesSize; ++i) {
        int currentPileSize = pilesColSize[i];
        int* currentPile = piles[i];

        int* prefixSums = (int*)malloc((currentPileSize + 1) * sizeof(int));
        prefixSums[0] = 0;
        for (int c = 0; c < currentPileSize; ++c) {
            prefixSums[c + 1] = prefixSums[c] + currentPile[c];
        }

        for (int j = k; j >= 0; --j) {
            for (int c = 1; c <= currentPileSize && c <= j; ++c) {
                if (dp[j - c] != INT_MIN) {
                    dp[j] = max(dp[j], dp[j - c] + prefixSums[c]);
                }
            }
        }

        free(prefixSums);
    }

    int result = 0;
    for(int i = 0; i <= k; ++i) {
        result = max(result, dp[i]);
    }

    free(dp);
    return result;
}