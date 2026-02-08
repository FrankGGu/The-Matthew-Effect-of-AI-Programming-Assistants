class Solution {
    private int m, n, introCost, extroCost;
    private int[][][] dp;

    public int getMaxGridHappiness(int m, int n, int introvertsCount, int extrovertsCount) {
        this.m = m;
        this.n = n;
        this.introCost = introvertsCount;
        this.extroCost = extrovertsCount;
        this.dp = new int[m * n][introCost + 1][extroCost + 1];
        for (int i = 0; i < m * n; i++) {
            for (int j = 0; j <= introCost; j++) {
                for (int k = 0; k <= extroCost; k++) {
                    dp[i][j][k] = -1;
                }
            }
        }
        return solve(0, introCost, extroCost, 0);
    }

    private int solve(int pos, int intro, int extro, int prev) {
        if (pos == m * n) {
            return 0;
        }
        if (dp[pos][intro][extro] != -1) {
            return dp[pos][intro][extro];
        }

        int row = pos / n;
        int col = pos % n;
        int ans = solve(pos + 1, intro, extro, 0);

        if (intro > 0) {
            int score = 120;
            if (col > 0 && prev == 1) score -= 30;
            if (col > 0 && prev == 2) score -= -20;
            if (row > 0 && dp[(row - 1) * n + col][introCost][extroCost] != -1) {
                int up = 0;
                if (dp[(row - 1) * n + col][introCost][extroCost] != -1) {
                    if (dp[(row - 1) * n + col][introCost][extroCost] == 1) up = 1;
                    if (dp[(row - 1) * n + col][introCost][extroCost] == 2) up = 2;
                }

                if (up == 1) score -= 30;
                if (up == 2) score -= -20;
            }
            dp[pos][intro][extro] = 1;
            ans = Math.max(ans, score + solve(pos + 1, intro - 1, extro, 1));
            dp[pos][intro][extro] = -1;
        }

        if (extro > 0) {
            int score = 40;
            if (col > 0 && prev == 1) score -= -20;
            if (col > 0 && prev == 2) score -= 30;
            if (row > 0 && dp[(row - 1) * n + col][introCost][extroCost] != -1) {
                int up = 0;
                if (dp[(row - 1) * n + col][introCost][extroCost] != -1) {
                    if (dp[(row - 1) * n + col][introCost][extroCost] == 1) up = 1;
                    if (dp[(row - 1) * n + col][introCost][extroCost] == 2) up = 2;
                }
                if (up == 1) score -= -20;
                if (up == 2) score -= 30;
            }
            dp[pos][intro][extro] = 2;
            ans = Math.max(ans, score + solve(pos + 1, intro, extro - 1, 2));
            dp[pos][intro][extro] = -1;
        }

        return dp[pos][intro][extro] = ans;
    }
}