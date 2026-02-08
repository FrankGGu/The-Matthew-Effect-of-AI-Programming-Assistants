#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int giveGem(int* gem, int gemSize, int** operations, int operationsSize, int* operationsColSize) {
    for (int i = 0; i < operationsSize; i++) {
        int x = operations[i][0];
        int y = operations[i][1];
        int amount = gem[x] / 2;
        gem[x] -= amount;
        gem[y] += amount;
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

    return maxGem - minGem;
}