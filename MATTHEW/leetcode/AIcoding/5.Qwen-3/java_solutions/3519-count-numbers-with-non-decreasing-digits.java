public class Solution {
    public int numNonDecreasingDigits(int n) {
        int[] dp = new int[10];
        for (int i = 0; i < 10; i++) {
            dp[i] = 1;
        }
        for (int i = 2; i <= n; i++) {
            for (int j = 0; j < 10; j++) {
                for (int k = j; k < 10; k++) {
                    dp[k] += dp[j];
                }
            }
        }
        int result = 0;
        for (int i = 0; i < 10; i++) {
            result += dp[i];
        }
        return result;
    }
}