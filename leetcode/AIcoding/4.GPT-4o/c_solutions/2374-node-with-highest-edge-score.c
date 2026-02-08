#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *edges;
    int edgesSize;
} Graph;

int highestEdgeScore(int* edges, int edgesSize) {
    long long *score = (long long *)calloc(edgesSize, sizeof(long long));
    int maxScoreIndex = -1;
    long long maxScore = -1;

    for (int i = 0; i < edgesSize; i++) {
        score[edges[i]] += i;
    }

    for (int i = 0; i < edgesSize; i++) {
        if (score[i] > maxScore || (score[i] == maxScore && i < maxScoreIndex)) {
            maxScore = score[i];
            maxScoreIndex = i;
        }
    }

    free(score);
    return maxScoreIndex;
}