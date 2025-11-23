#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findChampion(int n, int** edges, int edgesSize, int* edgesColSize) {
    int indegree[n];
    for (int i = 0; i < n; i++) {
        indegree[i] = 0;
    }
    for (int i = 0; i < edgesSize; i++) {
        indegree[edges[i][1]]++;
    }
    int champion = -1;
    for (int i = 0; i < n; i++) {
        if (indegree[i] == 0) {
            if (champion == -1) {
                champion = i;
            } else {
                return -1;
            }
        }
    }
    return champion;
}