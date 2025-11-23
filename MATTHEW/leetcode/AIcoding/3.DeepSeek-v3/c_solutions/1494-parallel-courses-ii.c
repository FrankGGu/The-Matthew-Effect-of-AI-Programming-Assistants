int minNumberOfSemesters(int n, int** relations, int relationsSize, int* relationsColSize, int k) {
    int *prereq = (int *)calloc(n, sizeof(int));
    for (int i = 0; i < relationsSize; i++) {
        int u = relations[i][0] - 1;
        int v = relations[i][1] - 1;
        prereq[v] |= (1 << u);
    }

    int *dp = (int *)malloc(sizeof(int) * (1 << n));
    for (int i = 0; i < (1 << n); i++) {
        dp[i] = n;
    }
    dp[0] = 0;

    int *valid = (int *)malloc(sizeof(int) * (1 << n));
    for (int mask = 0; mask < (1 << n); mask++) {
        valid[mask] = 0;
        for (int i = 0; i < n; i++) {
            if ((mask & (1 << i)) == 0 && (prereq[i] & mask) == prereq[i]) {
                valid[mask] |= (1 << i);
            }
        }
    }

    for (int mask = 0; mask < (1 << n); mask++) {
        int available = valid[mask];
        for (int sub = available; sub; sub = (sub - 1) & available) {
            if (__builtin_popcount(sub) <= k) {
                if (dp[mask | sub] > dp[mask] + 1) {
                    dp[mask | sub] = dp[mask] + 1;
                }
            }
        }
    }

    int result = dp[(1 << n) - 1];
    free(prereq);
    free(dp);
    free(valid);
    return result;
}