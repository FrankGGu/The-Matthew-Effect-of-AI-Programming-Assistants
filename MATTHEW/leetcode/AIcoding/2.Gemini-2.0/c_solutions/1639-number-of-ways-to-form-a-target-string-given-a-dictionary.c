#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int numWays(char ** words, int wordsSize, char * target){
    int targetLen = strlen(target);
    int wordLen = strlen(words[0]);
    long long dp[targetLen + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    int freq[wordLen][26];
    memset(freq, 0, sizeof(freq));

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < wordLen; j++) {
            freq[j][words[i][j] - 'a']++;
        }
    }

    for (int i = 0; i < wordLen; i++) {
        for (int j = targetLen - 1; j >= 0; j--) {
            dp[j + 1] += dp[j] * freq[i][target[j] - 'a'];
            dp[j + 1] %= MOD;
        }
    }

    return (int)dp[targetLen];
}