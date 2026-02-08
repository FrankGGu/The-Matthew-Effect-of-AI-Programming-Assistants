class Solution {
    public int minimumDamage(int[][] spells, int power) {
        int n = spells.length;
        int[][] dp = new int[n + 1][power + 1];

        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= power; j++) {
                if (i == 0 || j == 0) {
                    dp[i][j] = 0;
                } else {
                    int damageWithSpell = spells[i - 1][0];
                    int costWithSpell = spells[i - 1][1];

                    dp[i][j] = dp[i - 1][j];

                    if (j >= costWithSpell) {
                        dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - costWithSpell] + damageWithSpell);
                    }
                }
            }
        }

        return dp[n][power];
    }
}