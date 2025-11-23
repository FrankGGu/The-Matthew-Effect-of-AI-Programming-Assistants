class Solution {
    public int minimumDistance(String word) {
        int n = word.length();
        int[][][] dp = new int[n + 1][26][26];
        for (int i = n - 1; i >= 0; i--) {
            int c = word.charAt(i) - 'A';
            for (int a = 0; a < 26; a++) {
                for (int b = 0; b < 26; b++) {
                    dp[i][a][b] = Math.min(
                        dp[i + 1][c][b] + cost(a, c),
                        dp[i + 1][a][c] + cost(b, c)
                    );
                }
            }
        }
        return dp[0][word.charAt(0) - 'A'][26 - 1];
    }

    private int cost(int a, int b) {
        if (a == 26) return 0;
        int x1 = a / 6, y1 = a % 6;
        int x2 = b / 6, y2 = b % 6;
        return Math.abs(x1 - x2) + Math.abs(y1 - y2);
    }
}