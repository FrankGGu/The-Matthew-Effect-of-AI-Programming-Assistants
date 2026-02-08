#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int n, int* startPos, int startPosSize, int* homePos, int homePosSize, int* rowCosts, int rowCostsSize, int* colCosts, int colCostsSize) {
    int cost = 0;
    if (startPos[0] < homePos[0]) {
        for (int i = startPos[0] + 1; i <= homePos[0]; i++) {
            cost += rowCosts[i];
        }
    } else if (startPos[0] > homePos[0]) {
        for (int i = startPos[0] - 1; i >= homePos[0]; i--) {
            cost += rowCosts[i];
        }
    }

    if (startPos[1] < homePos[1]) {
        for (int i = startPos[1] + 1; i <= homePos[1]; i++) {
            cost += colCosts[i];
        }
    } else if (startPos[1] > homePos[1]) {
        for (int i = startPos[1] - 1; i >= homePos[1]; i--) {
            cost += colCosts[i];
        }
    }

    return cost;
}