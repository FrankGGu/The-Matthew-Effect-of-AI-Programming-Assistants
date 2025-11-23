int cmp(const void* a, const void* b) {
    int* eventA = *(int**)a;
    int* eventB = *(int**)b;
    return eventA[1] - eventB[1];
}

int maxValue(int** events, int eventsSize, int* eventsColSize, int k) {
    qsort(events, eventsSize, sizeof(int*), cmp);

    int** dp = (int**)malloc((eventsSize + 1) * sizeof(int*));
    for (int i = 0; i <= eventsSize; i++) {
        dp[i] = (int*)malloc((k + 1) * sizeof(int));
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= eventsSize; i++) {
        int start = events[i-1][0];
        int value = events[i-1][2];

        int left = 0, right = i - 2;
        int prev = 0;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (events[mid][1] < start) {
                prev = mid + 1;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        for (int j = 1; j <= k; j++) {
            dp[i][j] = dp[i-1][j] > dp[prev][j-1] + value ? dp[i-1][j] : dp[prev][j-1] + value;
        }
    }

    int result = 0;
    for (int j = 1; j <= k; j++) {
        if (dp[eventsSize][j] > result) {
            result = dp[eventsSize][j];
        }
    }

    for (int i = 0; i <= eventsSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}