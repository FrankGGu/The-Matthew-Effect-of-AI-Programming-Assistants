long long min(long long a, long long b) {
    return a < b ? a : b;
}

long long dfs(int* cost, int costSize, long long target, long long* memo) {
    if (target == 0) return 0;
    if (target == 1) return cost[0];
    if (memo[target] != -1) return memo[target];

    long long res = target * cost[0];
    for (int i = 1; i < costSize; i++) {
        int step = i + 1;
        long long prev = target / step;
        long long next = prev + 1;

        long long cost1 = cost[i] + dfs(cost, costSize, prev, memo) + (target - prev * step) * cost[0];
        long long cost2 = cost[i] + dfs(cost, costSize, next, memo) + (next * step - target) * cost[0];

        res = min(res, min(cost1, cost2));
    }

    memo[target] = res;
    return res;
}

int busRapidTransit(int target, int inc, int dec, int* jump, int jumpSize, int* cost, int costSize) {
    long long* memo = (long long*)malloc((target + 1) * sizeof(long long));
    for (int i = 0; i <= target; i++) memo[i] = -1;

    int newCost[jumpSize + 1];
    newCost[0] = inc;
    for (int i = 0; i < jumpSize; i++) {
        newCost[i + 1] = cost[i];
    }

    long long result = dfs(newCost, jumpSize + 1, target, memo) % 1000000007;
    free(memo);
    return result;
}