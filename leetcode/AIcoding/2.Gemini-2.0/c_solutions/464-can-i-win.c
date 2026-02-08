#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canWin(int maxChoosableInteger, int desiredTotal) {
    if (desiredTotal <= 0) {
        return true;
    }
    if ((1 + maxChoosableInteger) * maxChoosableInteger / 2 < desiredTotal) {
        return false;
    }

    int memo[1 << 20];
    memset(memo, -1, sizeof(memo));

    bool canWinHelper(int used, int remainingTotal, int maxInt, int *memo) {
        if (memo[used] != -1) {
            return memo[used];
        }

        for (int i = 1; i <= maxInt; i++) {
            if (!(used & (1 << (i - 1)))) {
                if (i >= remainingTotal || !canWinHelper(used | (1 << (i - 1)), remainingTotal - i, maxInt, memo)) {
                    memo[used] = true;
                    return true;
                }
            }
        }

        memo[used] = false;
        return false;
    }

    return canWinHelper(0, desiredTotal, maxChoosableInteger, memo);
}