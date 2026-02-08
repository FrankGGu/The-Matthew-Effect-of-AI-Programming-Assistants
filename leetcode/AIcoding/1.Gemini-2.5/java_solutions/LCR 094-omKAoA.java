class Solution {
    public int minCut(String s) {
        int n = s.length();

        boolean[][] isPalindrome = new boolean[n][n];

        for (int i = n - 1; i >= 0; i--) {
            for (int j = i; j < n; j++) {
                if (s.charAt(i) == s.charAt(j) && (j - i <= 1 || isPalindrome[i + 1][j - 1])) {
                    isPalindrome[i][j] = true;
                }
            }
        }

        int[] dp = new int[n + 1];

        for (int i = 0; i <= n; i++) {
            dp[i] = i - 1; 
        }

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j < i; j++) {
                if (isPalindrome[j][i - 1]) {
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                }
            }
        }

        return dp[n];
    }
}