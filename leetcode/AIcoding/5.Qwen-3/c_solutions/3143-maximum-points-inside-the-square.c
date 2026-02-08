#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxPointsInsideSquare(int* points, int pointsSize, int* reward, int rewardSize) {
    int n = pointsSize / 2;
    int* x = (int*)malloc(n * sizeof(int));
    int* y = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        x[i] = points[2 * i];
        y[i] = points[2 * i + 1];
    }

    int* sortedX = (int*)malloc(n * sizeof(int));
    int* sortedY = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        sortedX[i] = x[i];
        sortedY[i] = y[i];
    }
    qsort(sortedX, n, sizeof(int), compare);
    qsort(sortedY, n, sizeof(int), compare);

    int* freqX = (int*)calloc(n, sizeof(int));
    int* freqY = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        freqX[i] = 1;
        for (int j = i + 1; j < n; j++) {
            if (sortedX[i] == sortedX[j]) {
                freqX[i]++;
                freqX[j] = 0;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        freqY[i] = 1;
        for (int j = i + 1; j < n; j++) {
            if (sortedY[i] == sortedY[j]) {
                freqY[i]++;
                freqY[j] = 0;
            }
        }
    }

    int maxFreqX = 0;
    for (int i = 0; i < n; i++) {
        if (freqX[i] > maxFreqX) {
            maxFreqX = freqX[i];
        }
    }

    int maxFreqY = 0;
    for (int i = 0; i < n; i++) {
        if (freqY[i] > maxFreqY) {
            maxFreqY = freqY[i];
        }
    }

    int minMaxFreq = (maxFreqX < maxFreqY) ? maxFreqX : maxFreqY;

    int totalReward = 0;
    for (int i = 0; i < n; i++) {
        if (freqX[i] == minMaxFreq || freqY[i] == minMaxFreq) {
            totalReward += reward[i];
        }
    }

    free(x);
    free(y);
    free(sortedX);
    free(sortedY);
    free(freqX);
    free(freqY);

    return totalReward;
}