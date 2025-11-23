int getMaxGridHappiness(int m, int n, int introvertsCount, int extrovertsCount) {
    int T = 1;
    for (int i = 0; i < n; i++) T *= 3;

    int dp[6][7][7][729];
    memset(dp, -1, sizeof(dp));

    int base[729][6];
    int pre[729][6];
    memset(base, 0, sizeof(base));
    memset(pre, 0, sizeof(pre));

    for (int state = 0; state < T; state++) {
        int tmp = state;
        for (int j = 0; j < n; j++) {
            base[state][j] = tmp % 3;
            tmp /= 3;
        }
        for (int j = 0; j < n; j++) {
            if (base[state][j] == 0) continue;
            if (j > 0 && base[state][j-1] != 0) {
                pre[state][j] += 1;
                pre[state][j-1] += 1;
            }
        }
    }

    int bonus[3][3] = {{0, 0, 0}, {0, -60, -10}, {0, -10, 40}};

    dp[0][0][0][0] = 0;
    for (int i = 0; i < m; i++) {
        for (int x = 0; x <= introvertsCount; x++) {
            for (int y = 0; y <= extrovertsCount; y++) {
                for (int state = 0; state < T; state++) {
                    if (dp[i][x][y][state] < 0) continue;
                    for (int next = 0; next < T; next++) {
                        int intro = 0, extro = 0, score = 0;
                        for (int j = 0; j < n; j++) {
                            if (base[next][j] == 1) intro++;
                            else if (base[next][j] == 2) extro++;
                            if (base[next][j] != 0) {
                                score += (base[next][j] == 1 ? 120 : 40);
                                if (j > 0 && base[next][j-1] != 0) {
                                    score += bonus[base[next][j]][base[next][j-1]];
                                }
                                if (base[state][j] != 0) {
                                    score += bonus[base[next][j]][base[state][j]];
                                }
                            }
                        }
                        if (x + intro <= introvertsCount && y + extro <= extrovertsCount) {
                            int &res = dp[i+1][x+intro][y+extro][next];
                            if (res < dp[i][x][y][state] + score) {
                                res = dp[i][x][y][state] + score;
                            }
                        }
                    }
                }
            }
        }
    }

    int ans = 0;
    for (int x = 0; x <= introvertsCount; x++) {
        for (int y = 0; y <= extrovertsCount; y++) {
            for (int state = 0; state < T; state++) {
                if (dp[m][x][y][state] > ans) ans = dp[m][x][y][state];
            }
        }
    }
    return ans;
}