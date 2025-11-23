int tallestBillboard(int* rods, int rodsSize) {
    int sum = 0;
    for (int i = 0; i < rodsSize; i++) {
        sum += rods[i];
    }

    int dp[sum + 1];
    for (int i = 0; i <= sum; i++) {
        dp[i] = -1;
    }
    dp[0] = 0;

    for (int i = 0; i < rodsSize; i++) {
        int curr = rods[i];
        int temp[sum + 1];
        for (int j = 0; j <= sum; j++) {
            temp[j] = dp[j];
        }

        for (int diff = 0; diff <= sum; diff++) {
            if (temp[diff] < 0) continue;

            if (diff + curr <= sum) {
                dp[diff + curr] = (dp[diff + curr] > temp[diff]) ? dp[diff + curr] : temp[diff];
            }

            if (curr > diff) {
                dp[curr - diff] = (dp[curr - diff] > temp[diff] + diff) ? dp[curr - diff] : temp[diff] + diff;
            } else {
                dp[diff - curr] = (dp[diff - curr] > temp[diff] + curr) ? dp[diff - curr] : temp[diff] + curr;
            }
        }
    }

    return dp[0];
}