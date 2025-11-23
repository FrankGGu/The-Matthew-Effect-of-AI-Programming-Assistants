#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findLexicographicallySmallestValidSequence(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int* visited = (int*)calloc(n, sizeof(int));
    int* adj = (int*)malloc(n * sizeof(int));
    int* edgeCount = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u] = v;
        edgeCount[u]++;
    }

    int index = 0;
    for (int i = 0; i < n; i++) {
        if (edgeCount[i] == 0) {
            result[index++] = i;
            visited[i] = 1;
        }
    }

    for (int i = 0; i < n; i++) {
        if (visited[i] == 0) {
            int current = i;
            while (edgeCount[current] > 0) {
                int next = adj[current];
                if (visited[next] == 0) {
                    result[index++] = next;
                    visited[next] = 1;
                }
                current = next;
            }
        }
    }

    *returnSize = n;
    return result;
}