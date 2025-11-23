class Solution {
    int rows, cols;
    char[][] grid;
    int mJump, cJump;
    int[][][][][] dp; // dp[mouse_row][mouse_col][cat_row][cat_col][turn]

    // turn: 0 for mouse, 1 for cat
    // Result: 0 (Draw), 1 (Mouse wins), 2 (Cat wins)
    public int catAndMouse(String[] gridStr, int m_jump, int c_jump) {
        rows = gridStr.length;
        cols = gridStr[0].length();
        grid = new char[rows][cols];
        mJump = m_jump;
        cJump = c_jump;

        int mouseR = -1, mouseC = -1;
        int catR = -1, catC = -1;

        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                grid[r][c] = gridStr[r].charAt(c);
                if (grid[r][c] == 'M') {
                    mouseR = r;
                    mouseC = c;
                } else if (grid[r][c] == 'C') {
                    catR = r;
                    catC = c;
                }
            }
        }

        dp = new int[rows][cols][rows][cols][2];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                for (int k = 0; k < rows; k++) {
                    for (int l = 0; l < cols; l++) {
                        dp[i][j][k][l][0] = -1; // -1 indicates uncomputed
                        dp[i][j][k][l][1] = -1;
                    }
                }
            }
        }

        return solve(mouseR, mouseC, catR, catC, 0);
    }

    int[] dr = {-1, 1, 0, 0};
    int[] dc = {0, 0, -1, 1};

    private int solve(int mr, int mc, int cr, int cc, int turn) {
        // Base cases
        // Cat catches mouse
        if (mr == cr && mc == cc) {
            return 2; // Cat wins
        }
        // Mouse reaches food
        if (grid[mr][mc] == 'F') {
            return 1; // Mouse wins
        }
        // Cat reaches food
        if (grid[cr][cc] == 'F') {
            return 2; // Cat wins
        }

        // Memoization
        if (dp[mr][mc][cr][cc][turn] != -1) {
            return dp[mr][mc][cr][cc][turn];
        }

        // Mark as currently computing (potential draw if cycle detected)
        dp[mr][mc][cr][cc][turn] = 0; // Temporarily set to Draw

        if (turn == 0) { // Mouse's turn
            boolean canMouseWin = false;
            boolean canMouseDraw = false;

            for (int i = 0; i < 4; i++) { // 4 directions
                for (int j = 0; j <= mJump; j++) { // Jump distance
                    int nmr = mr + dr[i] * j;
                    int nmc = mc + dc[i] * j;

                    if (nmr < 0 || nmr >= rows || nmc < 0 || nmc >= cols || grid[nmr][nmc] == '#') {
                        if (j > 0) break; // Cannot move past an obstacle
                        else continue; // If j=0 and current cell is obstacle, skip (should not happen as M is not on #)
                    }

                    int res = solve(nmr, nmc, cr, cc, 1); // Next turn is Cat's
                    if (res == 1) { // Mouse found a winning move
                        canMouseWin = true;
                        break; 
                    }
                    if (res == 0) { // Mouse found a move leading to a draw
                        canMouseDraw = true;
                    }
                }
                if (canMouseWin) break;
            }

            if (canMouseWin) {
                dp[mr][mc][cr][cc][turn] = 1;
            } else if (canMouseDraw) {
                dp[mr][mc][cr][cc][turn] = 0;
            } else {
                dp[mr][mc][cr][cc][turn] = 2; // All moves lead to Cat win
            }

        } else { // Cat's turn
            boolean canCatWin = false;
            boolean canCatDraw = false;

            for (int i = 0; i < 4; i++) { // 4 directions
                for (int j = 0; j <= cJump; j++) { // Jump distance
                    int ncr = cr + dr[i] * j;
                    int ncc = cc + dc[i] * j;

                    if (ncr < 0 || ncr >= rows || ncc < 0 || ncc >= cols || grid[ncr][ncc] == '#') {
                        if (j > 0) break; // Cannot move past an obstacle
                        else continue; // If j=0 and current cell is obstacle, skip (should not happen as C is not on #)
                    }

                    int res = solve(mr, mc, ncr, ncc, 0); // Next turn is Mouse's
                    if (res == 2) { // Cat found a winning move
                        canCatWin = true;
                        break; 
                    }
                    if (res == 0) { // Cat found a move leading to a draw
                        canCatDraw = true;
                    }
                }
                if (canCatWin) break;
            }

            if (canCatWin) {
                dp[mr][mc][cr][cc][turn] = 2;
            } else if (canCatDraw) {
                dp[mr][mc][cr][cc][turn] = 0;
            } else {
                dp[mr][mc][cr][cc][turn] = 1; // All moves lead to Mouse win
            }
        }

        return dp[mr][mc][cr][cc][turn];
    }
}