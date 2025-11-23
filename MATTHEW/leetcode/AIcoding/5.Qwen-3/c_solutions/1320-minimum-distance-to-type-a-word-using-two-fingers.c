#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumDistance(char * word) {
    int n = strlen(word);
    int dp[2][26];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 26; j++) {
            dp[i][j] = -1;
        }
    }
    dp[0][word[0] - 'a'] = 0;
    dp[1][word[0] - 'a'] = 0;

    for (int i = 1; i < n; i++) {
        int curr = i % 2;
        int prev = 1 - curr;
        for (int j = 0; j < 26; j++) {
            dp[curr][j] = -1;
        }
        int c = word[i] - 'a';
        for (int j = 0; j < 26; j++) {
            if (dp[prev][j] != -1) {
                int cost = abs((j / 6) - (c / 6)) + abs((j % 6) - (c % 6));
                if (dp[curr][j] < dp[prev][j] + cost) {
                    dp[curr][j] = dp[prev][j] + cost;
                }
                if (dp[curr][c] < dp[prev][j] + cost) {
                    dp[curr][c] = dp[prev][j] + cost;
                }
            }
        }
    }

    int res = INT_MAX;
    for (int i = 0; i < 26; i++) {
        if (dp[n % 2][i] != -1 && dp[n % 2][i] < res) {
            res = dp[n % 2][i];
        }
    }
    return res;
}