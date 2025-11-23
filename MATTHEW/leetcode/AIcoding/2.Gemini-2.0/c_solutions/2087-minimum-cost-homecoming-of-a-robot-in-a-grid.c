#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int startRow, int startCol, int homeRow, int homeCol, int* rowCosts, int rowCostsSize, int* colCosts, int colCostsSize) {
    int cost = 0;
    int i;

    if (startRow < homeRow) {
        for (i = startRow + 1; i <= homeRow; i++) {
            cost += rowCosts[i];
        }
    } else if (startRow > homeRow) {
        for (i = startRow - 1; i >= homeRow; i--) {
            cost += rowCosts[i];
        }
    }

    if (startCol < homeCol) {
        for (i = startCol + 1; i <= homeCol; i++) {
            cost += colCosts[i];
        }
    } else if (startCol > homeCol) {
        for (i = startCol - 1; i >= homeCol; i--) {
            cost += colCosts[i];
        }
    }

    return cost;
}