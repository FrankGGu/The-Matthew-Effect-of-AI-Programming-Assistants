class Solution {
    public int numWays(String[] words, String target) {
        int m = words.length, n = words[0].length(), t = target.length();
        long[][] dp = new long[t + 1][n + 1];
        int[][] count = new int[26][n];

        for (String word : words) {
            for (int j = 0; j < n; j++) {
                count[word.charAt(j) - 'a'][j]++;
            }
        }

        dp[0][0] = 1;

        for (int i = 1; i <= t; i++) {
            for (int j = 1; j <= n; j++) {
                dp[i][j] = dp[i][j - 1];
                if (target.charAt(i - 1) - 'a' < 26) {
                    dp[i][j] += dp[i - 1][j - 1] * count[target.charAt(i - 1) - 'a'][j - 1];
                }
                dp[i][j] %= 1000000007;
            }
        }

        return (int) dp[t][n];
    }
}