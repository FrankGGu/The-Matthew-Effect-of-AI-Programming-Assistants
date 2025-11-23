#include <stdio.h>
#include <stdlib.h>

int minCost(int** startPos, int startPosSize, int* homePos, int homePosSize, int** rowCosts, int rowCostsSize, int* rowCostsColSize, int** colCosts, int colCostsSize, int* colCostsColSize) {
    int x = startPos[0][0];
    int y = startPos[0][1];
    int homeX = homePos[0];
    int homeY = homePos[1];
    int cost = 0;

    if (x < homeX) {
        for (int i = x; i < homeX; i++) {
            cost += rowCosts[i][0];
        }
    } else {
        for (int i = x; i > homeX; i--) {
            cost += rowCosts[i][0];
        }
    }

    if (y < homeY) {
        for (int j = y; j < homeY; j++) {
            cost += colCosts[j][0];
        }
    } else {
        for (int j = y; j > homeY; j--) {
            cost += colCosts[j][0];
        }
    }

    return cost;
}