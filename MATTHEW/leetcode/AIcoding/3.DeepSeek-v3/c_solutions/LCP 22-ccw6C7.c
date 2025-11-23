int paintingPlan(int n, int k) {
    if (k == n * n) return 1;
    int res = 0;
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            if (i * n + j * n - i * j == k) {
                int c1 = 1, c2 = 1;
                for (int x = 1; x <= i; x++) {
                    c1 = c1 * (n - x + 1) / x;
                }
                for (int x = 1; x <= j; x++) {
                    c2 = c2 * (n - x + 1) / x;
                }
                res += c1 * c2;
            }
        }
    }
    return res;
}