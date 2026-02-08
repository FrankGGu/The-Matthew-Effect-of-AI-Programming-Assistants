int minIncrements(int n, int* cost, int costSize) {
    int res = 0;
    for (int i = n / 2 - 1; i >= 0; i--) {
        int left = 2 * i + 1;
        int right = 2 * i + 2;
        res += abs(cost[left] - cost[right]);
        cost[i] += (cost[left] > cost[right]) ? cost[left] : cost[right];
    }
    return res;
}