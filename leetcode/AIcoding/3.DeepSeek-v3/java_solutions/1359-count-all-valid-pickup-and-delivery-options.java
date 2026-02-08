class Solution {
    public int countOrders(int n) {
        long MOD = 1_000_000_007;
        long res = 1;
        for (int i = 1; i <= n; i++) {
            res = res * i % MOD;
            res = res * (2 * i - 1) % MOD;
        }
        return (int) res;
    }
}