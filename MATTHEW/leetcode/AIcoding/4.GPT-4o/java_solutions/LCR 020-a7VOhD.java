public class Solution {
    public int countSubstrings(String s) {
        int count = 0;
        int n = s.length();
        boolean[][] dp = new boolean[n][n];

        for (int len = 1; len <= n; len++) {
            for (int start = 0; start <= n - len; start++) {
                int end = start + len - 1;
                if (s.charAt(start) == s.charAt(end)) {
                    if (len < 3) {
                        dp[start][end] = true;
                    } else {
                        dp[start][end] = dp[start + 1][end - 1];
                    }
                    if (dp[start][end]) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
}