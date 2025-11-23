bool canIWin(int maxChoosableInteger, int desiredTotal) {
    if (desiredTotal <= 0) return true;
    if (maxChoosableInteger * (maxChoosableInteger + 1) / 2 < desiredTotal) return false;

    int size = maxChoosableInteger + 1;
    int *memo = (int *)calloc(1 << size, sizeof(int));

    bool dfs(int total, int state) {
        if (memo[state] != 0) return memo[state] == 1;
        for (int i = 1; i <= maxChoosableInteger; i++) {
            if (!(state & (1 << i))) {
                if (total + i >= desiredTotal || !dfs(total + i, state | (1 << i))) {
                    memo[state] = 1;
                    free(memo);
                    return true;
                }
            }
        }
        memo[state] = -1;
        free(memo);
        return false;
    }

    return dfs(0, 0);
}