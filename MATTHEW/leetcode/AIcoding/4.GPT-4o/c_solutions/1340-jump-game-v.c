int maxJumps(int* arr, int arrSize, int d) {
    int* dp = (int*)malloc(arrSize * sizeof(int));
    int maxJumps = 1;
    for (int i = 0; i < arrSize; i++) {
        dp[i] = 1;
    }

    for (int i = 0; i < arrSize; i++) {
        for (int j = i + 1; j <= i + d && j < arrSize; j++) {
            if (arr[j] < arr[i]) {
                dp[j] = fmax(dp[j], dp[i] + 1);
                maxJumps = fmax(maxJumps, dp[j]);
            } else {
                break;
            }
        }
        for (int j = i - 1; j >= i - d && j >= 0; j--) {
            if (arr[j] < arr[i]) {
                dp[j] = fmax(dp[j], dp[i] + 1);
                maxJumps = fmax(maxJumps, dp[j]);
            } else {
                break;
            }
        }
    }

    free(dp);
    return maxJumps;
}