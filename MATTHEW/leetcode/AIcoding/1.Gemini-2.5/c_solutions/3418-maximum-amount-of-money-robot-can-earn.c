#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maxAmountOfMoneyRobotCanEarn(int* money, int moneySize) {
    if (moneySize == 0) {
        return 0;
    }
    if (moneySize == 1) {
        return money[0];
    }

    int* dp = (int*)malloc(sizeof(int) * moneySize);

    dp[0] = money[0];
    dp[1] = money[0] + money[1];

    for (int i = 2; i < moneySize; i++) {
        dp[i] = money[i] + max(dp[i-1], dp[i-2]);
    }

    int result = dp[moneySize - 1];

    free(dp);

    return result;
}