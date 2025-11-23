#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestIdealString(char * s, int k){
    int n = strlen(s);
    int dp[26] = {0};
    int ans = 0;
    for (int i = 0; i < n; i++) {
        int c = s[i] - 'a';
        int max_len = 0;
        for (int j = 0; j < 26; j++) {
            if (abs(c - j) <= k) {
                max_len = fmax(max_len, dp[j]);
            }
        }
        dp[c] = max_len + 1;
        ans = fmax(ans, dp[c]);
    }
    return ans;
}