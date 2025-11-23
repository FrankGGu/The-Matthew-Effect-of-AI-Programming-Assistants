#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countGoodStrings(int maxLength, int minLength, int oneCount, int zeroCount) {
    int dp[2][2];
    dp[0][0] = 1;
    dp[0][1] = 0;
    for (int i = 1; i <= maxLength; i++) {
        dp[i % 2][0] = (dp[(i - 1) % 2][0] + dp[(i - 1) % 2][1]) % 1000000007;
        dp[i % 2][1] = (dp[(i - 1) % 2][0] * oneCount + dp[(i - 1) % 2][1] * zeroCount) % 1000000007;
    }
    int result = 0;
    for (int i = minLength; i <= maxLength; i++) {
        result = (result + dp[i % 2][1]) % 1000000007;
    }
    return result;
}