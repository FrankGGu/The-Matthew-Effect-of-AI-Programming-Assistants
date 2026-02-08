int* securityCheck(int* capacities, int capacitiesSize, int k, int* returnSize) {
    int mod = 1000000007;
    int* dp = (int*)calloc(k + 1, sizeof(int));
    dp[0] = 1;

    for (int i = 0; i < capacitiesSize; i++) {
        int cap = capacities[i] - 1;
        for (int j = k; j >= cap; j--) {
            dp[j] = (dp[j] + dp[j - cap]) % mod;
        }
    }

    *returnSize = 1;
    int* result = (int*)malloc(sizeof(int));
    result[0] = dp[k];
    free(dp);
    return result;
}