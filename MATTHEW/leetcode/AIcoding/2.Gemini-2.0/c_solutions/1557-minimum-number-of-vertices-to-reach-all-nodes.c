#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findSmallestSetOfVertices(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int* inDegree = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        inDegree[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        inDegree[edges[i][1]]++;
    }

    int* result = (int*)malloc(sizeof(int) * n);
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    return result;
}