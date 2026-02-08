#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    if (x[0] != y[0]) return x[0] - y[0];
    return x[1] - y[1];
}

int bestTeamWithNoConflicts(int* ages, int agesSize, int* scores, int scoresSize) {
    int n = agesSize;
    int **players = (int **)malloc(n * sizeof(int *));
    for (int i = 0; i < n; i++) {
        players[i] = (int *)malloc(2 * sizeof(int));
        players[i][0] = ages[i];
        players[i][1] = scores[i];
    }
    qsort(players, n, sizeof(int *), compare);

    int maxScore = 0;
    int *dp = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dp[i] = players[i][1];
        for (int j = 0; j < i; j++) {
            if (players[j][1] <= players[i][1]) {
                dp[i] = fmax(dp[i], dp[j] + players[i][1]);
            }
        }
        maxScore = fmax(maxScore, dp[i]);
    }
    free(dp);
    for (int i = 0; i < n; i++) free(players[i]);
    free(players);
    return maxScore;
}