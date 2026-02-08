int minCost(int* startPos, int startPosSize, int* homePos, int homePosSize, int* rowCosts, int rowCostsSize, int* colCosts, int colCostsSize) {
    int cost = 0;
    int r1 = startPos[0], c1 = startPos[1];
    int r2 = homePos[0], c2 = homePos[1];

    if (r1 < r2) {
        for (int i = r1 + 1; i <= r2; i++) {
            cost += rowCosts[i];
        }
    } else if (r1 > r2) {
        for (int i = r1 - 1; i >= r2; i--) {
            cost += rowCosts[i];
        }
    }

    if (c1 < c2) {
        for (int i = c1 + 1; i <= c2; i++) {
            cost += colCosts[i];
        }
    } else if (c1 > c2) {
        for (int i = c1 - 1; i >= c2; i--) {
            cost += colCosts[i];
        }
    }

    return cost;
}