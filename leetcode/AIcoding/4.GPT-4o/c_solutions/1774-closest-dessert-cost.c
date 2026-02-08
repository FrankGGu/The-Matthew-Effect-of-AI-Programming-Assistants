int closestCost(int* baseCosts, int baseSize, int* toppingCosts, int toppingSize, int target) {
    int closest = INT_MAX;
    int minDiff = INT_MAX;

    for (int i = 0; i < baseSize; i++) {
        int baseCost = baseCosts[i];
        for (int j = 0; j < (1 << (2 * toppingSize)); j++) {
            int toppingCost = 0;
            for (int k = 0; k < toppingSize; k++) {
                if (j & (1 << (2 * k))) {
                    toppingCost += toppingCosts[k];
                } else if (j & (1 << (2 * k + 1))) {
                    toppingCost += 2 * toppingCosts[k];
                }
            }
            int totalCost = baseCost + toppingCost;
            int diff = abs(totalCost - target);
            if (diff < minDiff || (diff == minDiff && totalCost < closest)) {
                closest = totalCost;
                minDiff = diff;
            }
        }
    }
    return closest;
}