#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findCenter(int** edges, int edgesSize, int* edgesColSize){
    int n = edgesSize + 1;
    int* degree = (int*)malloc(sizeof(int) * (n + 1));
    for (int i = 0; i <= n; i++) {
        degree[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        degree[edges[i][0]]++;
        degree[edges[i][1]]++;
    }

    for (int i = 1; i <= n; i++) {
        if (degree[i] == n - 1) {
            free(degree);
            return i;
        }
    }

    free(degree);
    return -1;
}