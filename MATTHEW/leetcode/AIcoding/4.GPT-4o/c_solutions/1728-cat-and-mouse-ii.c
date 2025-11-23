#define MAXN 150

int dp[MAXN][MAXN][2];

int dfs(int mouse, int cat, int turn, int* catJump, int catJumpSize) {
    if (mouse == 0) return 1; // mouse wins
    if (cat == mouse) return 2; // cat wins
    if (dp[mouse][cat][turn] != -1) return dp[mouse][cat][turn];

    int nextTurn = 1 - turn;
    if (turn == 0) { // mouse's turn
        for (int i = 0; i < catJumpSize; i++) {
            int newMouse = mouse - catJump[i];
            if (newMouse < 0) continue;
            if (dfs(newMouse, cat, nextTurn, catJump, catJumpSize) == 1) {
                return dp[mouse][cat][turn] = 1;
            }
        }
        return dp[mouse][cat][turn] = 2; // cat wins if all moves lead to cat's win
    } else { // cat's turn
        for (int i = 0; i < catJumpSize; i++) {
            int newCat = cat + catJump[i];
            if (newCat >= MAXN) continue;
            if (dfs(mouse, newCat, nextTurn, catJump, catJumpSize) == 2) {
                return dp[mouse][cat][turn] = 2;
            }
        }
        return dp[mouse][cat][turn] = 1; // mouse wins if all moves lead to mouse's win
    }
}

int catAndMouseGame(int* catJump, int catJumpSize) {
    memset(dp, -1, sizeof(dp));
    return dfs(1, 2, 0, catJump, catJumpSize);
}