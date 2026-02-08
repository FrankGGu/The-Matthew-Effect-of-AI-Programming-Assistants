#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100

int dp[MAXN][MAXN][MAXN];
int visited[MAXN][MAXN][MAXN];

int solve(char** grid, int m, int n, int catJump, int mouseJump) {
    int total = m * n;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 'T') {
                dp[i][j][0] = 2;
                visited[i][j][0] = 1;
            }
        }
    }

    for (int step = 1; step <= total * 2; step++) {
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < m; k++) {
                    for (int l = 0; l < n; l++) {
                        if (visited[i][j][step % 2] || (i == k && j == l)) continue;
                        int mouse = (step % 2 == 0) ? 0 : 1;
                        int flag = 0;
                        if (mouse == 0) {
                            for (int dx = -mouseJump; dx <= mouseJump; dx++) {
                                for (int dy = -mouseJump; dy <= mouseJump; dy++) {
                                    if (abs(dx) + abs(dy) > mouseJump) continue;
                                    int ni = i + dx;
                                    int nj = j + dy;
                                    if (ni >= 0 && ni < m && nj >= 0 && nj < n && grid[ni][nj] != 'W') {
                                        if (dp[ni][nj][step % 2] == 2) {
                                            flag = 1;
                                            break;
                                        }
                                    }
                                }
                                if (flag) break;
                            }
                            if (flag) {
                                dp[i][j][step % 2] = 1;
                                visited[i][j][step % 2] = 1;
                            } else {
                                dp[i][j][step % 2] = 2;
                                visited[i][j][step % 2] = 1;
                            }
                        } else {
                            for (int dx = -catJump; dx <= catJump; dx++) {
                                for (int dy = -catJump; dy <= catJump; dy++) {
                                    if (abs(dx) + abs(dy) > catJump) continue;
                                    int ni = k + dx;
                                    int nj = l + dy;
                                    if (ni >= 0 && ni < m && nj >= 0 && nj < n && grid[ni][nj] != 'W') {
                                        if (dp[ni][nj][step % 2] == 2) {
                                            flag = 1;
                                            break;
                                        }
                                    }
                                }
                                if (flag) break;
                            }
                            if (flag) {
                                dp[k][l][step % 2] = 1;
                                visited[k][l][step % 2] = 1;
                            } else {
                                dp[k][l][step % 2] = 2;
                                visited[k][l][step % 2] = 1;
                            }
                        }
                    }
                }
            }
        }
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 'M') {
                return dp[i][j][0];
            }
        }
    }
    return 0;
}

int canMouseWin(char** grid, int m, int n, int catJump, int mouseJump) {
    int result = solve(grid, m, n, catJump, mouseJump);
    return result == 1 ? 1 : 0;
}