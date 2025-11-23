#include <stdio.h>
#include <stdlib.h>

int findChampion(int n, int** edges, int edgesSize, int* edgesColSize) {
    int* inDegree = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        inDegree[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        inDegree[v]++;
    }

    int champion = -1;
    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            if (champion == -1) {
                champion = i;
            } else {
                return -1;
            }
        }
    }

    free(inDegree);
    return champion;
}