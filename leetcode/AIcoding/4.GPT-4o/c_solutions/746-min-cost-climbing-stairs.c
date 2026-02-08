int minCostClimbingStairs(int* cost, int costSize) {
    int first = 0, second = 0;
    for (int i = 2; i <= costSize; i++) {
        int temp = second;
        second = fmin(second + cost[i - 1], first + cost[i - 2]);
        first = temp;
    }
    return second;
}