#include <stdio.h>
#include <stdlib.h>

int dp[10001];

int winner(int n) {
    if (n == 0) return 0;
    if (dp[n] != -1) return dp[n];
    for (int i = 1; i * i <= n; i++) {
        if (winner(n - i * i) == 0) {
            dp[n] = 1;
            return 1;
        }
    }
    dp[n] = 0;
    return 0;
}

int stoneGameIV(int n){
    for (int i = 0; i <= n; i++) {
        dp[i] = -1;
    }
    return winner(n);
}