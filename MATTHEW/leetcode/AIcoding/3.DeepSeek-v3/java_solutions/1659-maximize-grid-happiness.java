class Solution {
    private int m, n;
    private int[][][][][] dp;
    private int[] introvertsCount;
    private int[] extrovertsCount;
    private static final int MOD = 1 << 5;

    public int getMaxGridHappiness(int m, int n, int introvertsCount, int extrovertsCount) {
        this.m = m;
        this.n = n;
        this.introvertsCount = new int[]{introvertsCount};
        this.extrovertsCount = new int[]{extrovertsCount};
        this.dp = new int[m * n + 1][introvertsCount + 1][extrovertsCount + 1][1 << n][1 << n];
        return dfs(0, introvertsCount, extrovertsCount, 0, 0);
    }

    private int dfs(int pos, int in, int ex, int prevMask, int currMask) {
        if (pos == m * n) return 0;
        if (dp[pos][in][ex][prevMask][currMask] != 0) return dp[pos][in][ex][prevMask][currMask];
        int max = 0;
        int x = pos / n, y = pos % n;
        int nextMask = (currMask << 1) & ((1 << n) - 1);
        if (in > 0) {
            int score = 120;
            if (x > 0) score += getScore(1, (prevMask >> (n - 1)) & 1);
            if (y > 0) score += getScore(1, (currMask >> 0) & 1);
            max = Math.max(max, score + dfs(pos + 1, in - 1, ex, prevMask, nextMask | 1));
        }
        if (ex > 0) {
            int score = 40;
            if (x > 0) score += getScore(2, (prevMask >> (n - 1)) & 1);
            if (y > 0) score += getScore(2, (currMask >> 0) & 1);
            max = Math.max(max, score + dfs(pos + 1, in, ex - 1, prevMask, nextMask | 2));
        }
        max = Math.max(max, dfs(pos + 1, in, ex, prevMask, nextMask));
        dp[pos][in][ex][prevMask][currMask] = max;
        return max;
    }

    private int getScore(int type, int neighborType) {
        if (neighborType == 0) return 0;
        if (neighborType == 1) return type == 1 ? -60 : -10;
        else return type == 1 ? -10 : 40;
    }
}