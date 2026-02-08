int minimizeTotalPrice(int n, int** trips, int tripsSize, int* tripsColSize) {
    int dp[1001] = {0}, totalCost = 0;
    int booked[1001] = {0};

    for (int i = 0; i < tripsSize; i++) {
        int start = trips[i][0], end = trips[i][1], cost = trips[i][2];
        for (int j = end; j >= start; j--) {
            if (booked[j] == 0) {
                dp[j] = dp[j - 1] + cost;
                booked[j] = 1;
            } else {
                dp[j] = dp[j - 1];
            }
        }
    }

    for (int i = 0; i <= n; i++) {
        totalCost = totalCost < dp[i] ? totalCost : dp[i];
    }

    return totalCost;
}