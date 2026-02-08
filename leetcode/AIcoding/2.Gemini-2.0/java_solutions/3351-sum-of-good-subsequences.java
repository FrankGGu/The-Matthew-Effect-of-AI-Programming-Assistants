class Solution {
    private static final int MOD = 1000000007;

    public int sumOfGoodSubsequences(String s) {
        int n = s.length();
        long ans = 0;
        long pow2 = 1;
        boolean hasZero = false;

        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '0') {
                hasZero = true;
            } else {
                ans = (ans + pow2) % MOD;
                pow2 = (pow2 * 2) % MOD;
            }
        }

        if (hasZero) {
            ans = (ans + 1) % MOD;
        }

        return (int) ans;
    }
}