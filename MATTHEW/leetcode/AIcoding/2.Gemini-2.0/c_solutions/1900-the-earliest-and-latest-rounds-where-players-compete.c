#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

void solve(int n, int firstPlayer, int secondPlayer, int round, int minRound, int maxRound, int* minVal, int* maxVal, int* dpMin, int* dpMax) {
    if (firstPlayer == secondPlayer) {
        return;
    }

    if (firstPlayer + secondPlayer == n + 1) {
        *minVal = min(*minVal, round);
        *maxVal = max(*maxVal, round);
        return;
    }

    if (dpMin[(firstPlayer - 1) * n + secondPlayer - 1] != -1) {
        *minVal = min(*minVal, dpMin[(firstPlayer - 1) * n + secondPlayer - 1] + round -1);
        *maxVal = max(*maxVal, dpMax[(firstPlayer - 1) * n + secondPlayer - 1] + round -1);
        return;
    }

    for (int i = 1; i <= (n + 1) / 2; i++) {
        for (int j = n; j > (n + 1) / 2; j--) {
            if (i >= firstPlayer && j <= secondPlayer) {
                if (i == firstPlayer && j == secondPlayer) {
                    solve(n, (firstPlayer + 1) / 2, (secondPlayer + n + 1) / 2, round + 1, minRound, maxRound, minVal, maxVal, dpMin, dpMax);
                }
            } else if (i >= firstPlayer) {
                solve(n, (firstPlayer + 1) / 2, (j + n + 1) / 2, round + 1, minRound, maxRound, minVal, maxVal, dpMin, dpMax);
            } else if (j <= secondPlayer) {
                solve(n, (i + 1) / 2, (secondPlayer + n + 1) / 2, round + 1, minRound, maxRound, minVal, maxVal, dpMin, dpMax);
            } else {
                solve(n, (i + 1) / 2, (j + n + 1) / 2, round + 1, minRound, maxRound, minVal, maxVal, dpMin, dpMax);
            }
        }
    }

    dpMin[(firstPlayer - 1) * n + secondPlayer - 1] = *minVal - round + 1;
    dpMax[(firstPlayer - 1) * n + secondPlayer - 1] = *maxVal - round + 1;
}

int* earliestAndLatest(int n, int firstPlayer, int secondPlayer, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = n;
    result[1] = 1;

    int* dpMin = (int*)malloc(n * n * sizeof(int));
    int* dpMax = (int*)malloc(n * n * sizeof(int));

    for(int i = 0; i < n * n; i++){
        dpMin[i] = -1;
        dpMax[i] = -1;
    }

    solve(n, firstPlayer, secondPlayer, 1, 1, n, &result[0], &result[1], dpMin, dpMax);

    free(dpMin);
    free(dpMax);

    *returnSize = 2;
    return result;
}