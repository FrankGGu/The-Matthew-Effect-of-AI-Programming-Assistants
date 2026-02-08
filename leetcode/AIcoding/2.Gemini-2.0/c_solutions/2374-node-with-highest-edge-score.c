#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int highestEdgeScore(int* edges, int edgesSize){
    long long *scores = (long long*)calloc(edgesSize, sizeof(long long));

    for (int i = 0; i < edgesSize; i++) {
        scores[edges[i]] += i;
    }

    int maxNode = 0;
    long long maxScore = scores[0];

    for (int i = 1; i < edgesSize; i++) {
        if (scores[i] > maxScore) {
            maxScore = scores[i];
            maxNode = i;
        }
    }

    free(scores);
    return maxNode;
}