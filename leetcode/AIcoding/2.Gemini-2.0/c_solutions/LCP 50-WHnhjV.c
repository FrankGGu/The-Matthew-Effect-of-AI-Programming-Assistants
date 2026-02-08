#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* giveGem(int* gem, int gemSize, int** operations, int operationsSize, int* operationsColSize, int k, int* returnSize) {
    for (int i = 0; i < k; i++) {
        int x = operations[i][0];
        int y = operations[i][1];
        int give = gem[x] / 2;
        gem[x] -= give;
        gem[y] += give;
    }

    int maxGem = gem[0];
    int minGem = gem[0];
    for (int i = 1; i < gemSize; i++) {
        if (gem[i] > maxGem) {
            maxGem = gem[i];
        }
        if (gem[i] < minGem) {
            minGem = gem[i];
        }
    }

    int* result = (int*)malloc(sizeof(int));
    *result = maxGem - minGem;
    *returnSize = 1;
    return result;
}