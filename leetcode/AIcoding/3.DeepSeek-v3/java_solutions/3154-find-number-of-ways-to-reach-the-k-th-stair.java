class Solution {
    public int waysToReachStair(int k) {
        if (k == 0) return 1;
        int res = 0;
        int j = 0;
        while (true) {
            int m = (1 << j) - k;
            if (m < 0) {
                j++;
                continue;
            }
            if (m > j + 1) break;
            res += comb(j + 1, m);
            j++;
        }
        return res;
    }

    private int comb(int n, int k) {
        if (k < 0 || k > n) return 0;
        if (k == 0 || k == n) return 1;
        k = Math.min(k, n - k);
        long res = 1;
        for (int i = 1; i <= k; i++) {
            res = res * (n - k + i) / i;
        }
        return (int) res;
    }
}