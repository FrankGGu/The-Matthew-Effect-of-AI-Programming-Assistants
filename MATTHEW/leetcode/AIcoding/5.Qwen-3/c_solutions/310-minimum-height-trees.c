#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* neighbors;
    int size;
} AdjList;

int* findMinHeightTrees(int n, int* edges, int edgesSize, int* returnSize) {
    if (n == 1) {
        *returnSize = 1;
        int* result = (int*)malloc(sizeof(int));
        result[0] = 0;
        return result;
    }

    AdjList* adj = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        adj[i].neighbors = NULL;
        adj[i].size = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i * 2];
        int v = edges[i * 2 + 1];
        int* temp = (int*)realloc(adj[u].neighbors, (adj[u].size + 1) * sizeof(int));
        temp[adj[u].size++] = v;
        adj[u].neighbors = temp;

        temp = (int*)realloc(adj[v].neighbors, (adj[v].size + 1) * sizeof(int));
        temp[adj[v].size++] = u;
        adj[v].neighbors = temp;
    }

    int* degree = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        degree[i] = adj[i].size;
    }

    int* leaves = (int*)malloc(n * sizeof(int));
    int leafCount = 0;
    for (int i = 0; i < n; i++) {
        if (degree[i] == 1) {
            leaves[leafCount++] = i;
        }
    }

    while (n > 2) {
        int newLeafCount = 0;
        for (int i = 0; i < leafCount; i++) {
            int leaf = leaves[i];
            for (int j = 0; j < adj[leaf].size; j++) {
                int neighbor = adj[leaf].neighbors[j];
                if (degree[neighbor] > 0) {
                    degree[neighbor]--;
                    if (degree[neighbor] == 1) {
                        leaves[newLeafCount++] = neighbor;
                    }
                }
            }
            degree[leaf] = 0;
            n--;
        }
        leafCount = newLeafCount;
    }

    *returnSize = leafCount;
    int* result = (int*)malloc(leafCount * sizeof(int));
    memcpy(result, leaves, leafCount * sizeof(int));

    for (int i = 0; i < n; i++) {
        free(adj[i].neighbors);
    }
    free(adj);
    free(degree);
    free(leaves);

    return result;
}