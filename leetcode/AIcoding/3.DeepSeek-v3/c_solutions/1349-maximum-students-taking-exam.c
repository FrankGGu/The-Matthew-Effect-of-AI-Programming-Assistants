int maxStudents(char** seats, int seatsSize, int* seatsColSize) {
    int m = seatsSize, n = seatsColSize[0];
    int dp[1 << 8] = {0};
    int masks[9] = {0};

    for (int i = 0; i < m; i++) {
        int mask = 0;
        for (int j = 0; j < n; j++) {
            if (seats[i][j] == '.') {
                mask |= (1 << j);
            }
        }
        masks[i] = mask;
    }

    for (int i = 0; i < (1 << n); i++) {
        if ((i & masks[0]) == i && !(i & (i >> 1))) {
            dp[i] = __builtin_popcount(i);
        }
    }

    for (int i = 1; i < m; i++) {
        int temp[1 << 8] = {0};
        for (int j = 0; j < (1 << n); j++) {
            temp[j] = dp[j];
            dp[j] = 0;
        }

        for (int prev = 0; prev < (1 << n); prev++) {
            if (temp[prev] == -1) continue;
            for (int curr = 0; curr < (1 << n); curr++) {
                if ((curr & masks[i]) != curr) continue;
                if (curr & (curr >> 1)) continue;
                if ((curr & (prev >> 1)) || ((curr >> 1) & prev)) continue;
                dp[curr] = fmax(dp[curr], temp[prev] + __builtin_popcount(curr));
            }
        }
    }

    int res = 0;
    for (int i = 0; i < (1 << n); i++) {
        res = fmax(res, dp[i]);
    }
    return res;
}