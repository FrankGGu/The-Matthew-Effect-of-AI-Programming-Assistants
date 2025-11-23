#include <stdio.h>
#include <stdlib.h>

int* findSmallestSetOfVertices(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int* inDegree = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < edgesSize; ++i) {
        int dest = edges[i][1];
        inDegree[dest]++;
    }

    int count = 0;
    for (int i = 0; i < n; ++i) {
        if (inDegree[i] == 0) {
            count++;
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    int index = 0;
    for (int i = 0; i < n; ++i) {
        if (inDegree[i] == 0) {
            result[index++] = i;
        }
    }

    *returnSize = count;
    free(inDegree);
    return result;
}