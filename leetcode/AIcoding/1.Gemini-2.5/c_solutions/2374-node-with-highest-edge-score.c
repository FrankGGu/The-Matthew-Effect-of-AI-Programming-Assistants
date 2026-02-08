#include <stdlib.h>

int edgeScore(int* edges, int edgesSize) {
    long long* scores = (long long*)calloc(edgesSize, sizeof(long long));
    if (scores == NULL) {
        return -1; 
    }

    for (int j = 0; j < edgesSize; j++) {
        scores[edges[j]] += j;
    }

    long long maxScore = -1;
    int resultNode = -1;

    for (int i = 0; i < edgesSize; i++) {
        if (scores[i] > maxScore) {
            maxScore = scores[i];
            resultNode = i;
        }
    }

    free(scores);

    return resultNode;
}