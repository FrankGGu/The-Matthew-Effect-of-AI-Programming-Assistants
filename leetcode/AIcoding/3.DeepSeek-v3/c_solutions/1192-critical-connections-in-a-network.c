#include <stdlib.h>
#include <string.h>

/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int** criticalConnections(int n, int** connections, int connectionsSize, int* connectionsColSize, int* returnSize, int** returnColumnSizes) {
    int* adj[n];
    int adjSize[n];
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
        adjSize[i] = 0;
    }

    for (int i = 0; i < connectionsSize; i++) {
        int u = connections[i][0];
        int v = connections[i][1];
        adj[u][adjSize[u]++] = v;
        adj[v][adjSize[v]++] = u;
    }

    int* disc = (int*)malloc(n * sizeof(int));
    int* low = (int*)malloc(n * sizeof(int));
    int* parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        disc[i] = -1;
        low[i] = -1;
        parent[i] = -1;
    }

    int** result = (int**)malloc(connectionsSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(connectionsSize * sizeof(int));
    *returnSize = 0;

    int time = 0;

    void dfs(int u) {
        disc[u] = low[u] = time++;

        for (int i = 0; i < adjSize[u]; i++) {
            int v = adj[u][i];

            if (disc[v] == -1) {
                parent[v] = u;
                dfs(v);

                low[u] = (low[u] < low[v]) ? low[u] : low[v];

                if (low[v] > disc[u]) {
                    result[*returnSize] = (int*)malloc(2 * sizeof(int));
                    result[*returnSize][0] = u;
                    result[*returnSize][1] = v;
                    (*returnColumnSizes)[*returnSize] = 2;
                    (*returnSize)++;
                }
            } else if (v != parent[u]) {
                low[u] = (low[u] < disc[v]) ? low[u] : disc[v];
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if (disc[i] == -1) {
            dfs(i);
        }
    }

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(disc);
    free(low);
    free(parent);

    return result;
}