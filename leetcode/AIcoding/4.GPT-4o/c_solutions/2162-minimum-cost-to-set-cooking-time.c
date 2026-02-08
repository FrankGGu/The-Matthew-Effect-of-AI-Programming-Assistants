int minCostSetTime(int current, int moveCost, int cookCost, int target) {
    int minCost = INT_MAX;
    for (int h = 0; h <= 99; h++) {
        for (int m = 0; m < 60; m++) {
            int totalTime = h * 60 + m;
            if (totalTime < target) continue;
            int cost = abs(current - totalTime) * moveCost + (h > 0 || m > 0) * cookCost;
            if (totalTime == target) {
                minCost = fmin(minCost, cost);
            } else if (totalTime > target) {
                minCost = fmin(minCost, cost + (totalTime - target) * cookCost);
            }
        }
    }
    return minCost;
}