#include <stdlib.h>

int* findSmallestSetOfVertices(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int* inDegree = (int*)calloc(n, sizeof(int));
    if (inDegree == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        inDegree[edges[i][1]]++;
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            count++;
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    if (result == NULL) {
        free(inDegree);
        *returnSize = 0;
        return NULL;
    }

    *returnSize = count;
    int k = 0;
    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            result[k++] = i;
        }
    }

    free(inDegree);
    return result;
}