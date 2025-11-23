class Solution {
    public int sumOfGoodSubsequences(String s) {
        final int MOD = 1_000_000_007;
        long result = 0;
        long factor = 1;
        int count = 0;

        for (int i = s.length() - 1; i >= 0; i--) {
            if (s.charAt(i) == '1') {
                count++;
                result = (result + factor) % MOD;
            }
            factor = (factor * 2) % MOD;
        }

        return (int) (result * (count > 0 ? count : 1) % MOD);
    }
}