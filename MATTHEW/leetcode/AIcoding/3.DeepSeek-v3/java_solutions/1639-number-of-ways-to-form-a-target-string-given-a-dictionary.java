class Solution {
    public int numWays(String[] words, String target) {
        int mod = 1_000_000_007;
        int wordLen = words[0].length();
        int targetLen = target.length();
        if (wordLen < targetLen) {
            return 0;
        }

        int[][] count = new int[wordLen][26];
        for (String word : words) {
            for (int i = 0; i < wordLen; i++) {
                count[i][word.charAt(i) - 'a']++;
            }
        }

        long[][] dp = new long[targetLen + 1][wordLen + 1];
        dp[0][0] = 1;

        for (int i = 0; i <= targetLen; i++) {
            for (int j = 0; j <= wordLen; j++) {
                if (i == 0 && j == 0) {
                    continue;
                }
                if (i == 0) {
                    dp[i][j] = 1;
                } else if (j == 0) {
                    dp[i][j] = 0;
                } else {
                    dp[i][j] = dp[i][j - 1];
                    if (i <= targetLen && j <= wordLen && i > 0) {
                        char c = target.charAt(i - 1);
                        int cnt = count[j - 1][c - 'a'];
                        dp[i][j] += dp[i - 1][j - 1] * cnt;
                        dp[i][j] %= mod;
                    }
                }
            }
        }

        return (int) dp[targetLen][wordLen];
    }
}