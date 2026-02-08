#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long dp[20][2][11];
int digits[20];

int isBeautiful(int digit) {
    return digit != 0 && (7 % digit == 0);
}

long long dfs(int pos, int limit, int mod, int len) {
    if (pos == len) {
        return (mod == 0);
    }
    if (dp[pos][limit][mod] != -1) {
        return dp[pos][limit][mod];
    }

    long long ans = 0;
    int up = limit ? digits[pos] : 9;

    for (int i = 0; i <= up; ++i) {
        ans += dfs(pos + 1, limit && (i == digits[pos]), (mod * 10 + i) % 7, len);
    }

    return dp[pos][limit][mod] = ans;
}

long long solve(long long n) {
    int len = 0;
    while (n) {
        digits[len++] = n % 10;
        n /= 10;
    }

    for (int i = 0; i < len / 2; ++i) {
        int temp = digits[i];
        digits[i] = digits[len - i - 1];
        digits[len - i - 1] = temp;
    }

    for (int i = 0; i < 20; ++i) {
        for (int j = 0; j < 2; ++j) {
            for (int k = 0; k < 11; ++k) {
                dp[i][j][k] = -1;
            }
        }
    }

    return dfs(0, 1, 0, len);
}

int countBeautifulNumbers(int low, int high) {
    return solve(high) - solve(low - 1);
}