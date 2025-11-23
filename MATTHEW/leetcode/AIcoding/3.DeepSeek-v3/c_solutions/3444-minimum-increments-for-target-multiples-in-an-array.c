int minIncrements(int n, int* cost, int costSize) {
    int res = 0;
    for (int i = n / 2 - 1; i >= 0; i--) {
        int left = cost[2 * i + 1];
        int right = cost[2 * i + 2];
        res += abs(left - right);
        cost[i] += left > right ? left : right;
    }
    return res;
}