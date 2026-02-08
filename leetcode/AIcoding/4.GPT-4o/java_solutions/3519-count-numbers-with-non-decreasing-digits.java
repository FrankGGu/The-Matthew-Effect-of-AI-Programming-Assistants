class Solution {
    public int countNumbersWithNonDecreasingDigits(int n) {
        String numStr = String.valueOf(n);
        int length = numStr.length();
        int[][] dp = new int[length + 1][10];

        for (int i = 0; i <= 9; i++) {
            dp[1][i] = 1;
        }

        for (int i = 2; i <= length; i++) {
            for (int j = 0; j <= 9; j++) {
                for (int k = j; k <= 9; k++) {
                    dp[i][j] += dp[i - 1][k];
                }
            }
        }

        int count = 0;
        for (int i = 1; i < length; i++) {
            count += dp[i][0];
        }

        int prev = 0;
        for (int i = 0; i < length; i++) {
            int curr = numStr.charAt(i) - '0';
            for (int j = prev; j < curr; j++) {
                count += dp[length - i][j];
            }
            if (i > 0 && curr < prev) {
                break;
            }
            prev = curr;
        }
        return count + 1;
    }
}