bool canIWin(int maxChoosableInteger, int desiredTotal) {
    if (desiredTotal <= 0) return true;
    if ((maxChoosableInteger * (maxChoosableInteger + 1)) / 2 < desiredTotal) return false;

    bool *dp = (bool *)malloc(1 << maxChoosableInteger * sizeof(bool));
    memset(dp, 0, (1 << maxChoosableInteger) * sizeof(bool));

    for (int state = 0; state < (1 << maxChoosableInteger); state++) {
        for (int i = 0; i < maxChoosableInteger; i++) {
            if (state & (1 << i)) continue;
            int newTotal = desiredTotal - (i + 1);
            int newState = state | (1 << i);
            if (newTotal <= 0 || !dp[newState]) {
                dp[state] = true;
                break;
            }
        }
    }

    bool result = dp[0];
    free(dp);
    return result;
}