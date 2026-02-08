class Solution {
    private int[][][] memo;
    private int[][] graph;
    private int n;

    public int catMouseGame(int[][] graph) {
        this.graph = graph;
        this.n = graph.length;
        this.memo = new int[n][n][2 * n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                Arrays.fill(memo[i][j], -1);
            }
        }
        return dfs(1, 2, 0);
    }

    private int dfs(int mouse, int cat, int turn) {
        if (turn == 2 * n) {
            return 0;
        }
        if (mouse == 0) {
            return 1;
        }
        if (mouse == cat) {
            return 2;
        }
        if (memo[mouse][cat][turn] != -1) {
            return memo[mouse][cat][turn];
        }
        int result;
        if (turn % 2 == 0) {
            result = 2;
            for (int next : graph[mouse]) {
                int res = dfs(next, cat, turn + 1);
                if (res == 1) {
                    result = 1;
                    break;
                } else if (res == 0) {
                    result = 0;
                }
            }
        } else {
            result = 1;
            for (int next : graph[cat]) {
                if (next == 0) {
                    continue;
                }
                int res = dfs(mouse, next, turn + 1);
                if (res == 2) {
                    result = 2;
                    break;
                } else if (res == 0) {
                    result = 0;
                }
            }
        }
        memo[mouse][cat][turn] = result;
        return result;
    }
}