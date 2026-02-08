#include <stdlib.h>

int MOD = 1000000007;
int** memo_table;
int R_global, C_global;
int** Grid_global;

int dfs(int r, int c) {
    if (memo_table[r][c] != 0) {
        return memo_table[r][c];
    }

    long long count = 1;

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    for (int i = 0; i < 4; i++) {
        int nr = r + dr[i];
        int nc = c + dc[i];

        if (nr >= 0 && nr < R_global && nc >= 0 && nc < C_global && Grid_global[nr][nc] > Grid_global[r][c]) {
            count = (count + dfs(nr, nc)) % MOD;
        }
    }

    memo_table[r][c] = (int)count;
    return (int)count;
}

int countPaths(int** grid, int gridRowSize, int gridColSize) {
    R_global = gridRowSize;
    C_global = gridColSize;
    Grid_global = grid;

    memo_table = (int**)malloc(R_global * sizeof(int*));
    for (int i = 0; i < R_global; i++) {
        memo_table[i] = (int*)calloc(C_global, sizeof(int));
    }

    long long totalPaths = 0;

    for (int r = 0; r < R_global; r++) {
        for (int c = 0; c < C_global; c++) {
            totalPaths = (totalPaths + dfs(r, c)) % MOD;
        }
    }

    for (int i = 0; i < R_global; i++) {
        free(memo_table[i]);
    }
    free(memo_table);

    return (int)totalPaths;
}