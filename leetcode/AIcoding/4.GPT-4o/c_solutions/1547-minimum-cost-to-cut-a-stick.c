int minCost(int length, int* cuts, int cutsSize) {
    int* dp = (int*)malloc((length + 1) * sizeof(int));
    for (int i = 0; i <= length; i++) dp[i] = 0;
    int* allCuts = (int*)malloc((cutsSize + 2) * sizeof(int));
    allCuts[0] = 0;
    for (int i = 0; i < cutsSize; i++) allCuts[i + 1] = cuts[i];
    allCuts[cutsSize + 1] = length;

    qsort(allCuts + 1, cutsSize, sizeof(int), cmp);

    for (int len = 2; len <= cutsSize + 1; len++) {
        for (int i = 0; i + len <= cutsSize + 1; i++) {
            int minCost = INT_MAX;
            for (int j = i + 1; j < i + len; j++) {
                int cost = allCuts[i + len - 1] - allCuts[i] + dp[j - 1] + dp[i + len - 1 - j];
                if (cost < minCost) minCost = cost;
            }
            dp[i + len - 1] = minCost;
        }
    }
    int result = dp[cutsSize];
    free(dp);
    free(allCuts);
    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}