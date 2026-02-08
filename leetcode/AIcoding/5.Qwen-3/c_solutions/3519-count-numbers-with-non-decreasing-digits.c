#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countNumbersWithNonDecreasingDigits(int n) {
    int digits[11];
    int len = 0;
    int temp = n;
    while (temp > 0) {
        digits[len++] = temp % 10;
        temp /= 10;
    }

    long long dp[11][11];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i <= 9; i++) {
        dp[0][i] = 1;
    }

    for (int i = 1; i < len; i++) {
        for (int j = 0; j <= 9; j++) {
            for (int k = j; k <= 9; k++) {
                dp[i][j] += dp[i - 1][k];
            }
        }
    }

    long long result = 0;
    for (int i = 0; i <= digits[len - 1]; i++) {
        if (i == 0) continue;
        result += dp[len - 1][i];
    }

    for (int i = 1; i < len; i++) {
        for (int j = 1; j <= 9; j++) {
            result += dp[i - 1][j];
        }
    }

    return result;
}