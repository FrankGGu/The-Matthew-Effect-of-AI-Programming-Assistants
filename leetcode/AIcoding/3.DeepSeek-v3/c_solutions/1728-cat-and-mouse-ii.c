int dp[8][8][8][8][2][200];

int canMouseWin(char** grid, int gridSize, int* gridColSize, int catJump, int mouseJump) {
    int rows = gridSize, cols = gridColSize[0];
    int mx, my, cx, cy, fx, fy;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 'M') {
                mx = i;
                my = j;
            } else if (grid[i][j] == 'C') {
                cx = i;
                cy = j;
            } else if (grid[i][j] == 'F') {
                fx = i;
                fy = j;
            }
        }
    }

    memset(dp, -1, sizeof(dp));

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == '#') continue;
            for (int k = 0; k < rows; k++) {
                for (int l = 0; l < cols; l++) {
                    if (grid[k][l] == '#') continue;
                    if (i == k && j == l) {
                        dp[i][j][k][l][0][0] = 0;
                        dp[i][j][k][l][1][0] = 0;
                    } else if (i == fx && j == fy) {
                        dp[i][j][k][l][0][0] = 1;
                        dp[i][j][k][l][1][0] = 1;
                    } else if (k == fx && l == fy) {
                        dp[i][j][k][l][0][0] = 0;
                        dp[i][j][k][l][1][0] = 0;
                    } else {
                        dp[i][j][k][l][0][0] = 0;
                        dp[i][j][k][l][1][0] = 0;
                    }
                }
            }
        }
    }

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    for (int t = 1; t < 200; t++) {
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == '#') continue;
                for (int k = 0; k < rows; k++) {
                    for (int l = 0; l < cols; l++) {
                        if (grid[k][l] == '#') continue;
                        if (i == fx && j == fy) {
                            dp[i][j][k][l][0][t] = 1;
                            dp[i][j][k][l][1][t] = 1;
                            continue;
                        }
                        if (k == fx && l == fy) {
                            dp[i][j][k][l][0][t] = 0;
                            dp[i][j][k][l][1][t] = 0;
                            continue;
                        }
                        if (i == k && j == l) {
                            dp[i][j][k][l][0][t] = 0;
                            dp[i][j][k][l][1][t] = 0;
                            continue;
                        }

                        int mouseWin = 0;
                        int catWin = 0;

                        if (t % 2 == 0) {
                            for (int d = 0; d < 4; d++) {
                                for (int jump = 0; jump <= mouseJump; jump++) {
                                    int ni = i + dx[d] * jump;
                                    int nj = j + dy[d] * jump;
                                    if (ni < 0 || ni >= rows || nj < 0 || nj >= cols || grid[ni][nj] == '#') break;
                                    if (dp[ni][nj][k][l][1][t-1] == 1) {
                                        mouseWin = 1;
                                        break;
                                    }
                                }
                                if (mouseWin) break;
                            }
                            dp[i][j][k][l][0][t] = mouseWin;
                        } else {
                            for (int d = 0; d < 4; d++) {
                                for (int jump = 0; jump <= catJump; jump++) {
                                    int nk = k + dx[d] * jump;
                                    int nl = l + dy[d] * jump;
                                    if (nk < 0 || nk >= rows || nl < 0 || nl >= cols || grid[nk][nl] == '#') break;
                                    if (dp[i][j][nk][nl][0][t-1] == 0) {
                                        catWin = 1;
                                        break;
                                    }
                                }
                                if (catWin) break;
                            }
                            dp[i][j][k][l][1][t] = catWin;
                        }
                    }
                }
            }
        }
    }

    for (int t = 1; t < 200; t++) {
        if (dp[mx][my][cx][cy][0][t] == 1) {
            return 1;
        }
    }
    return 0;
}