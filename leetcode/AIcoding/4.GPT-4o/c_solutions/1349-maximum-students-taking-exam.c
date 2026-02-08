int maxStudents(char** seats, int seatsSize, int* seatsColSize) {
    int n = seatsSize, m = *seatsColSize;
    int dp[1 << m];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < n; i++) {
        int mask = 0;
        for (int j = 0; j < m; j++) {
            if (seats[i][j] == '.') {
                mask |= (1 << j);
            }
        }

        for (int j = (1 << m) - 1; j >= 0; j--) {
            if ((j & mask) == j) {
                int valid = 1;
                if (i > 0) {
                    if ((j & (j << 1)) || (j & (j >> 1))) {
                        valid = 0;
                    }
                }
                if (valid) {
                    dp[j] = fmax(dp[j], __builtin_popcount(j) + dp[mask & ~j]);
                }
            }
        }
    }

    int maxStudents = 0;
    for (int i = 0; i < (1 << m); i++) {
        maxStudents = fmax(maxStudents, dp[i]);
    }

    return maxStudents;
}