#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canEat(int* candiesCount, int candiesCountSize, int** queries, int queriesSize, int* queriesColSize, bool* returnSize) {
    *returnSize = queriesSize;
    bool* result = (bool*)malloc(sizeof(bool) * queriesSize);

    long long* prefixSum = (long long*)malloc(sizeof(long long) * (candiesCountSize + 1));
    prefixSum[0] = 0;
    for (int i = 0; i < candiesCountSize; i++) {
        prefixSum[i + 1] = prefixSum[i] + candiesCount[i];
    }

    for (int i = 0; i < queriesSize; i++) {
        int favoriteType = queries[i][0];
        int favoriteDay = queries[i][1];
        int dailyCap = queries[i][2];

        long long minCandiesNeeded = (long long)favoriteDay + 1;
        long long maxCandiesPossible = (long long)dailyCap * ((long long)favoriteDay + 1);

        long long candiesBeforeFavorite = prefixSum[favoriteType];
        long long candiesAvailable = prefixSum[favoriteType + 1];

        if (candiesBeforeFavorite < maxCandiesPossible && candiesAvailable > minCandiesNeeded - 1) {
            result[i] = true;
        } else {
            result[i] = false;
        }
    }

    free(prefixSum);
    return result;
}