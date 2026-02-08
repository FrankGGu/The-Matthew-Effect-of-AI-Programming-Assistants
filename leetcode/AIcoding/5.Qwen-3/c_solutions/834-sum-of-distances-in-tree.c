#include <stdio.h>
#include <stdlib.h>

int* sumOfDistancesInTree(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int* count = (int*)malloc(n * sizeof(int));
    int** tree = (int**)malloc(n * sizeof(int*));

    for (int i = 0; i < n; i++) {
        tree[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            tree[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        tree[u][v] = 1;
        tree[v][u] = 1;
    }

    for (int i = 0; i < n; i++) {
        count[i] = 1;
    }

    void dfs(int node, int parent) {
        for (int i = 0; i < n; i++) {
            if (tree[node][i] && i != parent) {
                dfs(i, node);
                count[node] += count[i];
                result[node] += result[i] + count[i];
            }
        }
    }

    void dfs2(int node, int parent) {
        for (int i = 0; i < n; i++) {
            if (tree[node][i] && i != parent) {
                result[i] = result[node] - count[i] + (n - count[i]);
                dfs2(i, node);
            }
        }
    }

    dfs(0, -1);
    dfs2(0, -1);

    *returnSize = n;
    return result;
}