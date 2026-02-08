class Solution {
    public int paintingPlan(int n, int k) {
        if (k < 0 || k > n * n) {
            return 0;
        }
        if (n == 0) {
            return k == 0 ? 1 : 0;
        }
        if (n == 1) {
            return k <= 1 ? 1 : 0;
        }

        if (k == 0) return 1;
        if (k == n * n) return 1;

        int count = 0;
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= n; j++) {
                if (i * n + j * n - i * j == k) {
                    if (i > n || j > n) continue;
                    count += combination(n, i) * combination(n, j);
                }
            }
        }
        return count;
    }

    private int combination(int n, int k) {
        if (k < 0 || k > n) {
            return 0;
        }
        if (k == 0 || k == n) {
            return 1;
        }
        if (k > n / 2) {
            k = n - k;
        }
        long res = 1;
        for (int i = 1; i <= k; i++) {
            res = res * (n - i + 1) / i;
        }
        return (int) res;
    }
}