#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countNumbersWithUniqueDigits(int n){
    if (n == 0) return 1;
    if (n > 10) n = 10;
    int dp[n + 1];
    dp[0] = 1;
    dp[1] = 10;
    int uniqueDigits = 9;
    int availableNumbers = 9;
    for (int i = 2; i <= n; i++) {
        uniqueDigits = uniqueDigits * availableNumbers;
        dp[i] = dp[i - 1] + uniqueDigits;
        availableNumbers--;
    }
    return dp[n];
}