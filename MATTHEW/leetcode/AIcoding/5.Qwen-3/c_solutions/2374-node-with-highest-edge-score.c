#include <stdio.h>
#include <stdlib.h>

int* getHighestScoreNode(int* edges, int edgesSize, int* returnSize) {
    int* score = (int*)calloc(edgesSize, sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        int neighbor = edges[i];
        if (neighbor < edgesSize) {
            score[neighbor]++;
        }
    }

    int maxScore = -1;
    int maxIndex = 0;
    for (int i = 0; i < edgesSize; i++) {
        if (score[i] > maxScore) {
            maxScore = score[i];
            maxIndex = i;
        }
    }

    *returnSize = 1;
    int* result = (int*)malloc(sizeof(int));
    result[0] = maxIndex;
    free(score);
    return result;
}