#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int videoStitching(int** clips, int clipsSize, int* clipsColSize, int time) {
    int dp[time + 1];
    for (int i = 0; i <= time; i++) {
        dp[i] = time + 1;
    }
    dp[0] = 0;

    for (int i = 1; i <= time; i++) {
        for (int j = 0; j < clipsSize; j++) {
            if (clips[j][0] <= i && i <= clips[j][1]) {
                dp[i] = (dp[clips[j][0]] + 1 < dp[i]) ? (dp[clips[j][0]] + 1) : dp[i];
            }
        }
    }

    return (dp[time] == time + 1) ? -1 : dp[time];
}