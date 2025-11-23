#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    int *x = *(int **)a;
    int *y = *(int **)b;
    if (x[0] != y[0]) {
        return x[0] - y[0];
    }
    return x[1] - y[1];
}

int bestTeamScore(int* scores, int scoresSize, int* ages, int agesSize) {
    int **players = (int **)malloc(scoresSize * sizeof(int *));
    for (int i = 0; i < scoresSize; i++) {
        players[i] = (int *)malloc(2 * sizeof(int));
        players[i][0] = ages[i];
        players[i][1] = scores[i];
    }

    qsort(players, scoresSize, sizeof(int *), cmp);

    int dp[scoresSize];
    int maxScore = 0;

    for (int i = 0; i < scoresSize; i++) {
        dp[i] = players[i][1];
        for (int j = 0; j < i; j++) {
            if (players[i][1] >= players[j][1]) {
                dp[i] = (dp[i] > dp[j] + players[i][1]) ? dp[i] : (dp[j] + players[i][1]);
            }
        }
        maxScore = (maxScore > dp[i]) ? maxScore : dp[i];
    }

    for (int i = 0; i < scoresSize; i++) {
        free(players[i]);
    }
    free(players);

    return maxScore;
}