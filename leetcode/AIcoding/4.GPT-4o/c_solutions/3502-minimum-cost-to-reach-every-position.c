int minCost(int* startPos, int startMoney, int* money, int moneySize, int* cost, int costSize) {
    int n = moneySize;
    int totalCost = 0;
    int minCost = startMoney;

    for (int i = 0; i < n; i++) {
        totalCost += cost[i];
    }

    for (int i = 0; i < n; i++) {
        if (startPos[0] + i < n) {
            minCost = fmin(minCost, startMoney - money[startPos[0] + i] + totalCost);
        }
        if (startPos[0] - i >= 0) {
            minCost = fmin(minCost, startMoney - money[startPos[0] - i] + totalCost);
        }
    }

    return minCost < 0 ? 0 : minCost;
}