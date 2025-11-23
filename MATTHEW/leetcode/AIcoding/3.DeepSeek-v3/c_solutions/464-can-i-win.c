int canWin(int maxChoosableInteger, int desiredTotal, int* memo, int state) {
    if (desiredTotal <= 0) return 0;
    if (memo[state] != -1) return memo[state];

    for (int i = 1; i <= maxChoosableInteger; i++) {
        int mask = 1 << i;
        if (state & mask) continue;

        if (!canWin(maxChoosableInteger, desiredTotal - i, memo, state | mask)) {
            memo[state] = 1;
            return 1;
        }
    }

    memo[state] = 0;
    return 0;
}

bool canIWin(int maxChoosableInteger, int desiredTotal) {
    if (maxChoosableInteger >= desiredTotal) return true;
    if ((maxChoosableInteger + 1) * maxChoosableInteger / 2 < desiredTotal) return false;

    int memo[1 << (maxChoosableInteger + 1)];
    for (int i = 0; i < (1 << (maxChoosableInteger + 1)); i++) memo[i] = -1;

    return canWin(maxChoosableInteger, desiredTotal, memo, 0);
}