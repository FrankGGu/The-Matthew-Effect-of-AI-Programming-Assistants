class Solution {
    public int countSpecialSubsequences(int[] nums) {
        long dp0 = 0;
        long dp1 = 0;
        long dp2 = 0;
        long MOD = 1_000_000_007;

        for (int num : nums) {
            if (num == 0) {
                dp0 = (2 * dp0 + 1) % MOD;
            } else if (num == 1) {
                dp1 = (2 * dp1 + dp0) % MOD;
            } else { // num == 2
                dp2 = (2 * dp2 + dp1) % MOD;
            }
        }

        return (int) dp2;
    }
}