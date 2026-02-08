#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfWays(int startPos, int endPos, int k) {
    int diff = abs(startPos - endPos);
    if (diff > k) {
        return 0;
    }
    if ((k - diff) % 2 != 0) {
        return 0;
    }

    long long n = k;
    long long r = (k + diff) / 2;

    if (r > n) return 0;

    long long dp[k + 1][k + 1];
    for(int i = 0; i <= n; i++){
        for(int j = 0; j <= i; j++){
            if(j == 0 || j == i){
                dp[i][j] = 1;
            } else {
                dp[i][j] = (dp[i - 1][j - 1] + dp[i - 1][j]) % 1000000007;
            }
        }
    }

    return (int)dp[n][r];
}