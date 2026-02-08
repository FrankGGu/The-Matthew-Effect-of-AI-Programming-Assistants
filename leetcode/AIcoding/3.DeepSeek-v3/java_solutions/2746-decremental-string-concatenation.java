class Solution {
    public int minimizeConcatenatedLength(String[] words) {
        int n = words.length;
        if (n == 0) return 0;

        int[][][] dp = new int[n][26][26];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < 26; j++) {
                Arrays.fill(dp[i][j], Integer.MAX_VALUE / 2);
            }
        }

        String firstWord = words[0];
        char firstChar = firstWord.charAt(0);
        char lastChar = firstWord.charAt(firstWord.length() - 1);
        dp[0][firstChar - 'a'][lastChar - 'a'] = firstWord.length();

        for (int i = 1; i < n; i++) {
            String current = words[i];
            int len = current.length();
            char currentFirst = current.charAt(0);
            char currentLast = current.charAt(len - 1);

            for (int a = 0; a < 26; a++) {
                for (int b = 0; b < 26; b++) {
                    if (dp[i - 1][a][b] == Integer.MAX_VALUE / 2) continue;

                    int newLen1 = dp[i - 1][a][b] + len - (currentFirst == (char) (b + 'a') ? 1 : 0;
                    int newA1 = a;
                    int newB1 = currentLast - 'a';
                    if (newLen1 < dp[i][newA1][newB1]) {
                        dp[i][newA1][newB1] = newLen1;
                    }

                    int newLen2 = dp[i - 1][a][b] + len - (currentLast == (char) (a + 'a') ? 1 : 0);
                    int newA2 = currentFirst - 'a';
                    int newB2 = b;
                    if (newLen2 < dp[i][newA2][newB2]) {
                        dp[i][newA2][newB2] = newLen2;
                    }
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int a = 0; a < 26; a++) {
            for (int b = 0; b < 26; b++) {
                if (dp[n - 1][a][b] < result) {
                    result = dp[n - 1][a][b];
                }
            }
        }
        return result;
    }
}