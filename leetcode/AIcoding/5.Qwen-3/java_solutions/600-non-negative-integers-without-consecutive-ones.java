public class Solution {
    public int nonNegativeIntegers(int n) {
        String binary = Integer.toBinaryString(n);
        int length = binary.length();
        int[][] dp = new int[length + 1][2];
        dp[0][0] = 1;
        for (int i = 1; i <= length; i++) {
            dp[i][0] = dp[i - 1][0] + dp[i - 1][1];
            dp[i][1] = dp[i - 1][0];
        }
        int result = dp[length][0] + dp[length][1];
        int count = 0;
        for (int i = 0; i < length - 1; i++) {
            if (binary.charAt(i) == '1' && binary.charAt(i + 1) == '1') {
                count++;
            }
        }
        if (count > 0) {
            result -= dp[length][0];
        }
        return result;
    }
}