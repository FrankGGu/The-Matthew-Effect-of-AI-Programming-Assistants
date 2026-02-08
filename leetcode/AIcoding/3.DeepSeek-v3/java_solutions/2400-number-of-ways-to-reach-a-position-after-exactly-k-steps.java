class Solution {
    private static final int MOD = 1000000007;

    public int numberOfWays(int startPos, int endPos, int k) {
        int diff = Math.abs(endPos - startPos);
        if (diff > k || (k - diff) % 2 != 0) {
            return 0;
        }
        int r = (k - diff) / 2;
        return comb(k, r);
    }

    private int comb(int n, int k) {
        if (k > n - k) {
            k = n - k;
        }
        long res = 1;
        for (int i = 1; i <= k; i++) {
            res = res * (n - k + i) / i;
            res %= MOD;
        }
        return (int) res;
    }
}