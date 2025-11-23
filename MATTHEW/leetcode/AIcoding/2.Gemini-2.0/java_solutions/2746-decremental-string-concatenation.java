class Solution {
    public int minimizeConcatenatedLength(String[] words) {
        int n = words.length;
        int[][][] dp = new int[n][26][26];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < 26; j++) {
                for (int k = 0; k < 26; k++) {
                    dp[i][j][k] = Integer.MAX_VALUE;
                }
            }
        }

        int firstStart = words[0].charAt(0) - 'a';
        int firstEnd = words[0].charAt(words[0].length() - 1) - 'a';
        dp[0][firstStart][firstEnd] = words[0].length();

        for (int i = 1; i < n; i++) {
            int curStart = words[i].charAt(0) - 'a';
            int curEnd = words[i].charAt(words[i].length() - 1) - 'a';
            int curLen = words[i].length();

            for (int j = 0; j < 26; j++) {
                for (int k = 0; k < 26; k++) {
                    if (dp[i - 1][j][k] != Integer.MAX_VALUE) {
                        int prevLen = dp[i - 1][j][k];
                        if (k == curStart) {
                            dp[i][j][curEnd] = Math.min(dp[i][j][curEnd], prevLen + curLen - 1);
                        } else {
                            dp[i][j][curEnd] = Math.min(dp[i][j][curEnd], prevLen + curLen);
                        }

                        if (curEnd == j) {
                            dp[i][curStart][k] = Math.min(dp[i][curStart][k], prevLen + curLen - 1);
                        } else {
                            dp[i][curStart][k] = Math.min(dp[i][curStart][k], prevLen + curLen);
                        }
                    }
                }
            }
        }

        int minLen = Integer.MAX_VALUE;
        for (int i = 0; i < 26; i++) {
            for (int j = 0; j < 26; j++) {
                minLen = Math.min(minLen, dp[n - 1][i][j]);
            }
        }

        return minLen;
    }
}