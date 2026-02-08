int minOperations(int n, int k) {
    int minOps = k;
    for (int x = 1; x <= k; x++) {
        int currentOps = x - 1 + (k + x - 1) / x - 1;
        if (currentOps < minOps) {
            minOps = currentOps;
        }
    }
    return minOps;
}