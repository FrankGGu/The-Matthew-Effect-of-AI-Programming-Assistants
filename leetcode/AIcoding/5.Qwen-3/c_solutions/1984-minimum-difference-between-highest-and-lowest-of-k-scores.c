#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int smallestDifference(int* scores, int scoresSize, int k) {
    qsort(scores, scoresSize, sizeof(int), compare);
    int minDiff = INT_MAX;
    for (int i = 0; i <= scoresSize - k; i++) {
        int diff = scores[i + k - 1] - scores[i];
        if (diff < minDiff) {
            minDiff = diff;
        }
    }
    return minDiff;
}