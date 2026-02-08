class Solution {
    private static final int MOD = 1000000007;

    public int countOrders(int n) {
        long ans = 1;
        for (int i = 1; i <= n; i++) {
            ans = (ans * i) % MOD;
            ans = (ans * (2 * i - 1)) % MOD;
        }
        return (int) ans;
    }
}