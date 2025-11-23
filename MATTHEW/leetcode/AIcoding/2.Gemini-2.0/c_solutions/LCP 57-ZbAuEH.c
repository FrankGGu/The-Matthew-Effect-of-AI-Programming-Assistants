#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxKilled(int** moles, int molesSize, int* molesColSize, int r, int c) {
    if (molesSize == 0) return 0;

    int dp[molesSize];
    for (int i = 0; i < molesSize; i++) {
        dp[i] = 1;
    }

    int max_killed = 1;
    for (int i = 1; i < molesSize; i++) {
        for (int j = 0; j < i; j++) {
            if (abs(moles[i][0] - moles[j][0]) + abs(moles[i][1] - moles[j][1]) <= moles[i][2] - moles[j][2]) {
                dp[i] = (dp[i] > dp[j] + 1) ? dp[i] : (dp[j] + 1);
            }
        }
        max_killed = (max_killed > dp[i]) ? max_killed : dp[i];
    }

    return max_killed;
}