class Solution {
    public int generateBinaryStrings(int n) {
        long mod = 1000000007;
        long[] dp0 = new long[n + 1];
        long[] dp1 = new long[n + 1];
        dp0[1] = 1;
        dp1[1] = 1;
        for (int i = 2; i <= n; i++) {
            dp0[i] = dp1[i - 1] % mod;
            dp1[i] = (dp0[i - 1] + dp1[i - 1]) % mod;
        }
        return (int)((dp0[n] + dp1[n]) % mod);
    }
}