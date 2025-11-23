#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findPaths(int m, int n, int maxMove, int startRow, int startCol) {
    int mod = 1000000007;
    int dp[51][51][51];
    memset(dp, -1, sizeof(dp));

    int dfs(int i, int j, int move) {
        if (i < 0 || j < 0 || i >= m || j >= n) return 1;
        if (move == 0) return 0;
        if (dp[i][j][move] != -1) return dp[i][j][move];

        int res = 0;
        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        for (int k = 0; k < 4; k++) {
            int ni = i + dirs[k][0];
            int nj = j + dirs[k][1];
            res = (res + dfs(ni, nj, move - 1)) % mod;
        }
        return dp[i][j][move] = res;
    }

    return dfs(startRow, startCol, maxMove);
}