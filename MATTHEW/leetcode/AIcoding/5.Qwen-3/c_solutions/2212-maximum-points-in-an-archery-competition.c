#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* maximumPoints(int** t, int n, int* returnSize) {
    *returnSize = 0;
    int* result = (int*)malloc(n * sizeof(int));
    if (!result) return NULL;

    int maxPoints = 0;
    int* bestShot = (int*)malloc(n * sizeof(int));
    if (!bestShot) {
        free(result);
        return NULL;
    }

    for (int i = 0; i < n; i++) {
        int points = 0;
        int* shot = (int*)malloc(n * sizeof(int));
        if (!shot) {
            free(result);
            free(bestShot);
            return NULL;
        }
        for (int j = 0; j < n; j++) {
            shot[j] = 0;
        }

        int totalArrows = 0;
        for (int j = 0; j < n; j++) {
            if (t[i][j] > 0) {
                shot[j] = 1;
                totalArrows += 1;
                points += t[i][j];
            }
        }

        if (totalArrows <= 1) {
            free(shot);
            continue;
        }

        for (int j = 0; j < n; j++) {
            if (t[i][j] > 0 && shot[j] == 1) {
                shot[j] = 2;
                totalArrows += 1;
                points += t[i][j];
            }
        }

        if (points > maxPoints) {
            maxPoints = points;
            memcpy(bestShot, shot, n * sizeof(int));
        }

        free(shot);
    }

    *returnSize = n;
    memcpy(result, bestShot, n * sizeof(int));
    free(bestShot);
    return result;
}