#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int numberOfWinningPlayers(int* scores, int scoresSize) {
    int* sorted = (int*)malloc(scoresSize * sizeof(int));
    for (int i = 0; i < scoresSize; i++) {
        sorted[i] = scores[i];
    }
    qsort(sorted, scoresSize, sizeof(int), compare);

    int count = 0;
    int maxScore = sorted[scoresSize - 1];
    for (int i = 0; i < scoresSize; i++) {
        if (scores[i] == maxScore) {
            count++;
        }
    }
    free(sorted);
    return count;
}