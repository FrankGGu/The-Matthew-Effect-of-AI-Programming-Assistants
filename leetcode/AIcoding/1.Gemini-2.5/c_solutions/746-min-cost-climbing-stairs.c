int min(int a, int b) {
    return (a < b) ? a : b;
}

int minCostClimbingStairs(int* cost, int costSize) {
    int prev2 = cost[0];
    int prev1 = cost[1];

    for (int i = 2; i < costSize; i++) {
        int current_dp_i = cost[i] + min(prev1, prev2);
        prev2 = prev1;
        prev1 = current_dp_i;
    }

    return min(prev1, prev2);
}