int canCross(int* stones, int stonesSize, int k) {
    int* dp = (int*)malloc(stonesSize * sizeof(int));
    memset(dp, 0, stonesSize * sizeof(int));
    dp[0] = 1;

    for (int i = 1; i < stonesSize; i++) {
        dp[i] = dp[i-1];
        if (stones[i] - stones[i-1] <= k) {
            dp[i] = 1;
        }
    }

    for (int i = stonesSize - 1; i >= 0; i--) {
        if (dp[i] == 1) {
            return stones[i];
        }
    }

    return 0;
}

int lastDayToCross(int* stones, int stonesSize) {
    int left = 1, right = stones[stonesSize - 1], result = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (canCross(stones, stonesSize, mid)) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}