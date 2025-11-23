class Solution {
    private static final int INF = 1_000_000_000;
    private int[][][] memo;
    private int[] houses;
    private int[][] cost;
    private int m;
    private int n;
    private int target;

    public int minCost(int[] houses, int[][] cost, int m, int n, int target) {
        this.houses = houses;
        this.cost = cost;
        this.m = m;
        this.n = n;
        this.target = target;
        this.memo = new int[m][n + 1][target + 1];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j <= n; j++) {
                Arrays.fill(memo[i][j], -1);
            }
        }

        int res = dfs(0, 0, 0);
        return res == INF ? -1 : res;
    }

    private int dfs(int i, int prevColor, int neighborhoods) {
        if (i == m) {
            return neighborhoods == target ? 0 : INF;
        }
        if (neighborhoods > target) {
            return INF;
        }
        if (memo[i][prevColor][neighborhoods] != -1) {
            return memo[i][prevColor][neighborhoods];
        }

        int res = INF;
        if (houses[i] != 0) {
            int newNeighborhoods = neighborhoods + (houses[i] == prevColor ? 0 : 1);
            res = dfs(i + 1, houses[i], newNeighborhoods);
        } else {
            for (int color = 1; color <= n; color++) {
                int newNeighborhoods = neighborhoods + (color == prevColor ? 0 : 1);
                int currentCost = cost[i][color - 1] + dfs(i + 1, color, newNeighborhoods);
                res = Math.min(res, currentCost);
            }
        }

        memo[i][prevColor][neighborhoods] = res;
        return res;
    }
}