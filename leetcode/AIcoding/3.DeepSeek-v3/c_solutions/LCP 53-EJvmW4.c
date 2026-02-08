int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int defenseSpaceCity(int* time, int timeSize, int* position, int positionSize) {
    int n = timeSize;
    int maxPos = 0;
    for (int i = 0; i < n; i++) {
        maxPos = max(maxPos, position[i]);
    }

    int m = maxPos + 1;
    int* mask = (int*)calloc(m, sizeof(int));
    for (int i = 0; i < n; i++) {
        mask[position[i]] |= 1 << (time[i] - 1);
    }

    int** dp = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        dp[i] = (int*)malloc(32 * sizeof(int));
        for (int j = 0; j < 32; j++) {
            dp[i][j] = 1000000;
        }
    }

    dp[0][0] = 0;

    for (int i = 0; i < m; i++) {
        for (int pre = 0; pre < 32; pre++) {
            if (dp[i][pre] >= 1000000) continue;

            for (int cur = 0; cur < 32; cur++) {
                int cost = 0;

                int cover = pre | cur;
                int must = mask[i];

                if ((cover & must) != must) continue;

                int overlap = pre & cur;

                for (int t = 0; t < 5; t++) {
                    if (cur & (1 << t)) {
                        if (overlap & (1 << t)) {
                            cost += 1;
                        } else {
                            cost += 2;
                        }
                    }
                }

                dp[i + 1][cur] = min(dp[i + 1][cur], dp[i][pre] + cost);
            }
        }
    }

    int res = 1000000;
    for (int i = 0; i < 32; i++) {
        res = min(res, dp[m][i]);
    }

    for (int i = 0; i <= m; i++) {
        free(dp[i]);
    }
    free(dp);
    free(mask);

    return res;
}