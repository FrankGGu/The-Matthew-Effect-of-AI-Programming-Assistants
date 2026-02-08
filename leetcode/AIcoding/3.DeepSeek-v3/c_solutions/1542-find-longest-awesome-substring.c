int longestAwesome(char* s) {
    int state = 0;
    int dp[1024];
    for (int i = 0; i < 1024; i++) dp[i] = -2;
    dp[0] = -1;
    int max_len = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        int digit = s[i] - '0';
        state ^= (1 << digit);

        if (dp[state] != -2) {
            max_len = fmax(max_len, i - dp[state]);
        } else {
            dp[state] = i;
        }

        for (int j = 0; j < 10; j++) {
            int new_state = state ^ (1 << j);
            if (dp[new_state] != -2) {
                max_len = fmax(max_len, i - dp[new_state]);
            }
        }
    }

    return max_len;
}