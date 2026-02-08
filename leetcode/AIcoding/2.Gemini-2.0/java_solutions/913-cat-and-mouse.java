class Solution {
    private static final int DRAW = 0;
    private static final int MOUSE_WIN = 1;
    private static final int CAT_WIN = 2;

    public int catMouseGame(int[][] graph) {
        int n = graph.length;
        int[][][] dp = new int[n][n][2 * n];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < 2 * n; k++) {
                    dp[i][j][k] = -1;
                }
            }
        }

        return solve(graph, 1, 2, 0, dp);
    }

    private int solve(int[][] graph, int mouse, int cat, int turns, int[][][] dp) {
        if (turns == 2 * graph.length) {
            return DRAW;
        }

        if (dp[mouse][cat][turns] != -1) {
            return dp[mouse][cat][turns];
        }

        if (mouse == cat) {
            dp[mouse][cat][turns] = CAT_WIN;
            return CAT_WIN;
        }

        if (mouse == 0) {
            dp[mouse][cat][turns] = MOUSE_WIN;
            return MOUSE_WIN;
        }

        if (turns % 2 == 0) {
            // Mouse's turn
            boolean catWin = true;
            for (int nextMouse : graph[mouse]) {
                int result = solve(graph, nextMouse, cat, turns + 1, dp);
                if (result == MOUSE_WIN) {
                    dp[mouse][cat][turns] = MOUSE_WIN;
                    return MOUSE_WIN;
                } else if (result == DRAW) {
                    catWin = false;
                }
            }
            if (catWin) {
                dp[mouse][cat][turns] = CAT_WIN;
                return CAT_WIN;
            } else {
                dp[mouse][cat][turns] = DRAW;
                return DRAW;
            }
        } else {
            // Cat's turn
            boolean mouseWin = true;
            for (int nextCat : graph[cat]) {
                if (nextCat != 0) {
                    int result = solve(graph, mouse, nextCat, turns + 1, dp);
                    if (result == CAT_WIN) {
                        dp[mouse][cat][turns] = CAT_WIN;
                        return CAT_WIN;
                    } else if (result == DRAW) {
                        mouseWin = false;
                    }
                }
            }
            if (mouseWin) {
                dp[mouse][cat][turns] = MOUSE_WIN;
                return MOUSE_WIN;
            } else {
                dp[mouse][cat][turns] = DRAW;
                return DRAW;
            }
        }
    }
}