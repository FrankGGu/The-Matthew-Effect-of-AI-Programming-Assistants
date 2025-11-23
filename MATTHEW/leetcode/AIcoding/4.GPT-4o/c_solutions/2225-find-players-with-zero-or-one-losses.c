#include <stdio.h>
#include <stdlib.h>

int* findWinners(int** matches, int matchesSize, int* matchesColSize, int* returnSize) {
    int* lossCount = (int*)calloc(100001, sizeof(int));
    for (int i = 0; i < matchesSize; i++) {
        lossCount[matches[i][1]]++;
    }

    int* winners = (int*)malloc(100001 * sizeof(int));
    int winnerCount = 0;
    int oneLossCount = 0;

    for (int i = 1; i <= 100000; i++) {
        if (lossCount[i] == 0) {
            winners[winnerCount++] = i;
        } else if (lossCount[i] == 1) {
            winners[100001 + oneLossCount++] = i;
        }
    }

    int* result = (int*)malloc((winnerCount + oneLossCount) * sizeof(int));
    for (int i = 0; i < winnerCount; i++) {
        result[i] = winners[i];
    }
    for (int i = 0; i < oneLossCount; i++) {
        result[winnerCount + i] = winners[100001 + i];
    }

    free(winners);
    free(lossCount);

    *returnSize = winnerCount + oneLossCount;
    qsort(result, *returnSize, sizeof(int), cmp);
    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}