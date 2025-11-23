int minStickers(char** stickers, int stickersSize, char* target) {
    int n = strlen(target);
    int totalStates = 1 << n;
    int* dp = (int*)malloc(totalStates * sizeof(int));
    for (int i = 0; i < totalStates; i++) dp[i] = -1;
    dp[0] = 0;

    for (int state = 0; state < totalStates; state++) {
        if (dp[state] == -1) continue;
        for (int i = 0; i < stickersSize; i++) {
            int now = state;
            int len = strlen(stickers[i]);
            int count[26] = {0};
            for (int j = 0; j < len; j++) {
                count[stickers[i][j] - 'a']++;
            }

            for (int j = 0; j < n; j++) {
                if ((now >> j) & 1) continue;
                if (count[target[j] - 'a'] > 0) {
                    count[target[j] - 'a']--;
                    now |= 1 << j;
                }
            }

            if (dp[now] == -1 || dp[now] > dp[state] + 1) {
                dp[now] = dp[state] + 1;
            }
        }
    }

    int result = dp[totalStates - 1];
    free(dp);
    return result;
}