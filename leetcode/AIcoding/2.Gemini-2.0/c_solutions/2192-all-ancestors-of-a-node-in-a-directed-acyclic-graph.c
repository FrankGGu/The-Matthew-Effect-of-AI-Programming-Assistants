#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** getAncestors(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize, int** returnColumnSizes) {
    int** adj = (int**)malloc(n * sizeof(int*));
    int* adjSize = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
        adjSize[i] = 0;
    }

    int* inDegree = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adjSize[u]++] = v;
        inDegree[v]++;
    }

    int** result = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = 0;
    }

    int* q = (int*)malloc(n * sizeof(int));
    int head = 0, tail = 0;
    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            q[tail++] = i;
        }
    }

    int** ancestors = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        ancestors[i] = (int*)calloc(n, sizeof(int));
    }

    while (head < tail) {
        int u = q[head++];
        for (int i = 0; i < adjSize[u]; i++) {
            int v = adj[u][i];
            ancestors[v][u] = 1;
            for (int j = 0; j < n; j++) {
                if (ancestors[u][j]) {
                    ancestors[v][j] = 1;
                }
            }
            inDegree[v]--;
            if (inDegree[v] == 0) {
                q[tail++] = v;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (ancestors[i][j]) {
                result[i][(*returnColumnSizes)[i]++] = j;
            }
        }
    }

    *returnSize = n;

    for (int i = 0; i < n; i++) {
        free(adj[i]);
        free(ancestors[i]);
    }
    free(adj);
    free(adjSize);
    free(inDegree);
    free(q);
    free(ancestors);

    return result;
}