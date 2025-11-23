class Solution {
    final int DRAW = 0;
    final int MOUSE_WIN = 1;
    final int CAT_WIN = 2;

    final int MOUSE_TURN = 0;
    final int CAT_TURN = 1;

    int N;
    int[][] graph;
    int[][][] dp;

    public int catAndMouse(int[][] graph) {
        this.graph = graph;
        N = graph.length;
        dp = new int[N][N][2];

        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                dp[i][j][0] = -1; // -1 indicates uncomputed state
                dp[i][j][1] = -1;
            }
        }

        return dfs(1, 2, MOUSE_TURN);
    }

    private int dfs(int mouse, int cat, int turn) {
        if (mouse == 0) {
            return MOUSE_WIN;
        }
        if (cat == mouse) {
            return CAT_WIN;
        }

        if (dp[mouse][cat][turn] != -1) {
            return dp[mouse][cat][turn];
        }

        dp[mouse][cat][turn] = DRAW; // Temporarily mark as DRAW to detect cycles

        if (turn == MOUSE_TURN) {
            boolean mouseCanWin = false;
            boolean mouseCanDraw = false;

            for (int nextMouse : graph[mouse]) {
                int outcome = dfs(nextMouse, cat, CAT_TURN);
                if (outcome == MOUSE_WIN) {
                    mouseCanWin = true;
                    break;
                }
                if (outcome == DRAW) {
                    mouseCanDraw = true;
                }
            }

            if (mouseCanWin) {
                dp[mouse][cat][turn] = MOUSE_WIN;
            } else if (mouseCanDraw) {
                dp[mouse][cat][turn] = DRAW;
            } else {
                dp[mouse][cat][turn] = CAT_WIN;
            }
        } else { // CAT_TURN
            boolean catCanWin = false;
            boolean catCanDraw = false;

            for (int nextCat : graph[cat]) {
                if (nextCat == 0) { // Cat cannot move to hole 0
                    continue;
                }
                int outcome = dfs(mouse, nextCat, MOUSE_TURN);
                if (outcome == CAT_WIN) {
                    catCanWin = true;
                    break;
                }
                if (outcome == DRAW) {
                    catCanDraw = true;
                }
            }

            if (catCanWin) {
                dp[mouse][cat][turn] = CAT_WIN;
            } else if (catCanDraw) {
                dp[mouse][cat][turn] = DRAW;
            } else {
                dp[mouse][cat][turn] = MOUSE_WIN;
            }
        }

        return dp[mouse][cat][turn];
    }
}