int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int backtrack(int* nums, int numsSize, int mask, int op, int* dp, int** gcdValues) {
    if (op * 2 > numsSize) return 0;
    if (dp[mask] != -1) return dp[mask];

    int maxScore = 0;
    for (int i = 0; i < numsSize; i++) {
        if (mask & (1 << i)) continue;
        for (int j = i + 1; j < numsSize; j++) {
            if (mask & (1 << j)) continue;
            int newMask = mask | (1 << i) | (1 << j);
            int currentScore = op * gcdValues[i][j];
            int remainingScore = backtrack(nums, numsSize, newMask, op + 1, dp, gcdValues);
            if (currentScore + remainingScore > maxScore) {
                maxScore = currentScore + remainingScore;
            }
        }
    }
    dp[mask] = maxScore;
    return maxScore;
}

int maxScore(int* nums, int numsSize) {
    int maxMask = 1 << numsSize;
    int* dp = (int*)malloc(maxMask * sizeof(int));
    for (int i = 0; i < maxMask; i++) {
        dp[i] = -1;
    }

    int** gcdValues = (int**)malloc(numsSize * sizeof(int*));
    for (int i = 0; i < numsSize; i++) {
        gcdValues[i] = (int*)malloc(numsSize * sizeof(int));
        for (int j = 0; j < numsSize; j++) {
            gcdValues[i][j] = gcd(nums[i], nums[j]);
        }
    }

    int result = backtrack(nums, numsSize, 0, 1, dp, gcdValues);

    for (int i = 0; i < numsSize; i++) {
        free(gcdValues[i]);
    }
    free(gcdValues);
    free(dp);

    return result;
}