class Solution {
    public boolean digitGame(int num) {
        String s = Integer.toString(num);
        int n = s.length();
        boolean[][] dp = new boolean[n][n];

        for (int i = n - 1; i >= 0; i--) {
            for (int j = i; j < n; j++) {
                if (i == j) {
                    dp[i][j] = true;
                } else {
                    boolean left = (s.charAt(i) == '1' || s.charAt(i) == '3' || s.charAt(i) == '5' || s.charAt(i) == '7' || s.charAt(i) == '9') ? !dp[i + 1][j] : dp[i + 1][j];
                    boolean right = (s.charAt(j) == '1' || s.charAt(j) == '3' || s.charAt(j) == '5' || s.charAt(j) == '7' || s.charAt(j) == '9') ? !dp[i][j - 1] : dp[i][j - 1];
                    dp[i][j] = left || right;
                }
            }
        }

        return dp[0][n - 1];
    }
}