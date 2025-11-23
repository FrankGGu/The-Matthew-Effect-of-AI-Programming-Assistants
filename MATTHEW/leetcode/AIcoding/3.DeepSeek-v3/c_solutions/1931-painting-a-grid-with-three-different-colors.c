int dp[1001][1024];

int colorTheGrid(int m, int n) {
    int mod = 1e9 + 7;
    int total_states = 1;
    for (int i = 0; i < m; i++) total_states *= 3;

    for (int state = 0; state < total_states; state++) {
        int valid = 1;
        int temp = state;
        int prev = -1;
        for (int i = 0; i < m; i++) {
            int color = temp % 3;
            if (color == prev) {
                valid = 0;
                break;
            }
            prev = color;
            temp /= 3;
        }
        dp[0][state] = valid ? 1 : 0;
    }

    for (int col = 1; col < n; col++) {
        for (int state = 0; state < total_states; state++) {
            dp[col][state] = 0;
            int temp_state = state;
            int colors[m];
            for (int i = 0; i < m; i++) {
                colors[i] = temp_state % 3;
                temp_state /= 3;
            }

            for (int prev_state = 0; prev_state < total_states; prev_state++) {
                if (dp[col-1][prev_state] == 0) continue;

                int temp_prev = prev_state;
                int valid = 1;
                for (int i = 0; i < m; i++) {
                    int prev_color = temp_prev % 3;
                    if (prev_color == colors[i]) {
                        valid = 0;
                        break;
                    }
                    temp_prev /= 3;
                }

                if (valid) {
                    dp[col][state] = (dp[col][state] + dp[col-1][prev_state]) % mod;
                }
            }
        }
    }

    int res = 0;
    for (int state = 0; state < total_states; state++) {
        res = (res + dp[n-1][state]) % mod;
    }
    return res;
}