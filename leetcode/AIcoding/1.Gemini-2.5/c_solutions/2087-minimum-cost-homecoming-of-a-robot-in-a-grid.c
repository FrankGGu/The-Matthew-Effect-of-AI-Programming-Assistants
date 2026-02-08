long long minCost(int* startPos, int startPosSize, int* homePos, int homePosSize, int* rowCosts, int rowCostsSize, int* colCosts, int colCostsSize) {
    long long totalCost = 0;

    int startRow = startPos[0];
    int startCol = startPos[1];
    int homeRow = homePos[0];
    int homeCol = homePos[1];

    // Calculate row movement costs
    if (startRow < homeRow) {
        for (int r = startRow + 1; r <= homeRow; r++) {
            totalCost += rowCosts[r];
        }
    } else if (startRow > homeRow) {
        for (int r = startRow - 1; r >= homeRow; r--) {
            totalCost += rowCosts[r];
        }
    }

    // Calculate column movement costs
    if (startCol < homeCol) {
        for (int c = startCol + 1; c <= homeCol; c++) {
            totalCost += colCosts[c];
        }
    } else if (startCol > homeCol) {
        for (int c = startCol - 1; c >= homeCol; c--) {
            totalCost += colCosts[c];
        }
    }

    return totalCost;
}