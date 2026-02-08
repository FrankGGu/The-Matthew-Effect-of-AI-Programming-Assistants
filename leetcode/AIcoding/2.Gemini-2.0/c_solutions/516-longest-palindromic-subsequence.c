#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestPalindromeSubseq(char * s){
    int n = 0;
    while(s[n] != '\0') n++;
    int dp[n][n];
    for(int i = 0; i < n; i++){
        for(int j = 0; j < n; j++){
            dp[i][j] = 0;
        }
    }
    for(int i = 0; i < n; i++){
        dp[i][i] = 1;
    }
    for(int len = 2; len <= n; len++){
        for(int i = 0; i <= n - len; i++){
            int j = i + len - 1;
            if(s[i] == s[j]){
                dp[i][j] = dp[i+1][j-1] + 2;
            } else {
                dp[i][j] = (dp[i+1][j] > dp[i][j-1]) ? dp[i+1][j] : dp[i][j-1];
            }
        }
    }
    return dp[0][n-1];
}