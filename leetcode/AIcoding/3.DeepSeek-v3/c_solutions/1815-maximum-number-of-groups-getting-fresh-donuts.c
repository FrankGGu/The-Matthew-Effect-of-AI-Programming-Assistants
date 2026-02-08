int dp[1<<13][13];

int maxHappyGroups(int batchSize, int* groups, int groupsSize) {
    int cnt[9] = {0};
    for (int i = 0; i < groupsSize; i++) {
        cnt[groups[i] % batchSize]++;
    }

    int res = cnt[0];
    cnt[0] = 0;

    for (int i = 1; i < batchSize; i++) {
        int j = batchSize - i;
        if (i < j) {
            int m = cnt[i] < cnt[j] ? cnt[i] : cnt[j];
            res += m;
            cnt[i] -= m;
            cnt[j] -= m;
        }
    }

    if (batchSize % 2 == 0) {
        int m = cnt[batchSize / 2] / 2;
        res += m;
        cnt[batchSize / 2] -= m * 2;
    }

    int state = 0;
    for (int i = 1; i < batchSize; i++) {
        state |= cnt[i] << (i * 5);
    }

    memset(dp, -1, sizeof(dp));

    int dfs(int state, int mod) {
        if (dp[state][mod] != -1) return dp[state][mod];
        int res = 0;
        for (int i = 1; i < batchSize; i++) {
            int cnt_i = (state >> (i * 5)) & 31;
            if (cnt_i > 0) {
                int new_state = state - (1 << (i * 5));
                int new_mod = (mod + i) % batchSize;
                int cur = (mod == 0) ? 1 : 0;
                res = (res > cur + dfs(new_state, new_mod)) ? res : cur + dfs(new_state, new_mod);
            }
        }
        return dp[state][mod] = res;
    }

    return res + dfs(state, 0);
}