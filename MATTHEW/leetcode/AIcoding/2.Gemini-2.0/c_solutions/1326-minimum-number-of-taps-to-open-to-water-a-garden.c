#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minTaps(int n, int* ranges, int rangesSize) {
    int* maxReach = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        maxReach[i] = i;
    }

    for (int i = 0; i < rangesSize; i++) {
        int left = i - ranges[i];
        int right = i + ranges[i];
        if (left < 0) {
            left = 0;
        }
        if (right > n) {
            right = n;
        }
        maxReach[left] = (maxReach[left] > right) ? maxReach[left] : right;
    }

    int taps = 0;
    int currentReach = 0;
    int nextReach = 0;

    for (int i = 0; i < n; i++) {
        nextReach = (nextReach > maxReach[i]) ? nextReach : maxReach[i];
        if (i == currentReach) {
            if (currentReach == nextReach) {
                free(maxReach);
                return -1;
            }
            taps++;
            currentReach = nextReach;
        }
    }

    free(maxReach);
    return taps;
}