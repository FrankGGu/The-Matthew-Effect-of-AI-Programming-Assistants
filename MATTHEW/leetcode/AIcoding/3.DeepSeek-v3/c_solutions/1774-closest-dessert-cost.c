int closestCost(int* baseCosts, int baseCostsSize, int* toppingCosts, int toppingCostsSize, int target) {
    int max_cost = 20000;
    int dp[max_cost + 1];
    for (int i = 0; i <= max_cost; i++) {
        dp[i] = 0;
    }

    for (int i = 0; i < baseCostsSize; i++) {
        if (baseCosts[i] <= max_cost) {
            dp[baseCosts[i]] = 1;
        }
    }

    for (int i = 0; i < toppingCostsSize; i++) {
        for (int count = 0; count < 2; count++) {
            for (int j = max_cost; j >= toppingCosts[i]; j--) {
                if (dp[j - toppingCosts[i]]) {
                    dp[j] = 1;
                }
            }
        }
    }

    int min_diff = INT_MAX;
    int result = 0;

    for (int i = 0; i <= max_cost; i++) {
        if (dp[i]) {
            int diff = abs(i - target);
            if (diff < min_diff || (diff == min_diff && i < result)) {
                min_diff = diff;
                result = i;
            }
        }
    }

    return result;
}