class Solution {
    private static final int MOD = 1000000007;

    public int numWays(String[] words, String target) {
        int m = target.length();
        int n = words[0].length();
        long[] dp = new long[m + 1];
        dp[0] = 1;

        int[][] count = new int[n][26];
        for (String word : words) {
            for (int i = 0; i < n; i++) {
                count[i][word.charAt(i) - 'a']++;
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = m - 1; j >= 0; j--) {
                dp[j + 1] = (dp[j + 1] + dp[j] * count[i][target.charAt(j) - 'a']) % MOD;
            }
        }

        return (int) dp[m];
    }
}