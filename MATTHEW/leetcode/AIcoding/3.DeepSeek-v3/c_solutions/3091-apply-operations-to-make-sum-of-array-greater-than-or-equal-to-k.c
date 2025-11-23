int minOperations(int k) {
    if (k == 1) return 0;

    int ans = INT_MAX;
    for (int i = 1; i <= k; i++) {
        int ops = i - 1;
        int copies = (k + i - 1) / i - 1;
        ans = ans < (ops + copies) ? ans : (ops + copies);
    }
    return ans;
}