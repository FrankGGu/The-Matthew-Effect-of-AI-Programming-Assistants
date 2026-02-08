#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numDecodings(char * s){
    int n = 0;
    while(s[n] != '\0') n++;
    if(n == 0) return 0;
    if(s[0] == '0') return 0;
    if(n == 1) return 1;

    int dp[n + 1];
    dp[0] = 1;
    dp[1] = 1;

    for(int i = 2; i <= n; i++){
        dp[i] = 0;
        if(s[i-1] != '0'){
            dp[i] += dp[i-1];
        }
        int twoDigit = (s[i-2] - '0') * 10 + (s[i-1] - '0');
        if(twoDigit >= 10 && twoDigit <= 26){
            dp[i] += dp[i-2];
        }
    }

    return dp[n];
}