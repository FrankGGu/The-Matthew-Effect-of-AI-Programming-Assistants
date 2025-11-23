public class Solution {
    public int minimumDistance(String word) {
        int[][] dp = new int[26][26];
        for (int i = 0; i < 26; i++) {
            for (int j = 0; j < 26; j++) {
                dp[i][j] = Integer.MAX_VALUE;
            }
        }
        for (int i = 0; i < 26; i++) {
            dp[i][i] = 0;
        }

        for (int i = 0; i < word.length(); i++) {
            int c = word.charAt(i) - 'a';
            int[][] newDp = new int[26][26];
            for (int a = 0; a < 26; a++) {
                for (int b = 0; b < 26; b++) {
                    if (dp[a][b] == Integer.MAX_VALUE) continue;
                    newDp[a][c] = Math.min(newDp[a][c], dp[a][b] + distance(b, c));
                    newDp[c][b] = Math.min(newDp[c][b], dp[a][b] + distance(a, c));
                }
            }
            dp = newDp;
        }

        int min = Integer.MAX_VALUE;
        for (int i = 0; i < 26; i++) {
            for (int j = 0; j < 26; j++) {
                min = Math.min(min, dp[i][j]);
            }
        }
        return min;
    }

    private int distance(int a, int b) {
        if (a == b) return 0;
        int[] x = {0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1};
        int[] y = {0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8};
        return Math.abs(x[a] - x[b]) + Math.abs(y[a] - y[b]);
    }
}