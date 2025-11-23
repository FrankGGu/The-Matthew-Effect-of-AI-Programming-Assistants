#include <limits.h>
#include <stdbool.h>
#include <stdlib.h>

int minTrioDegree(int n, int** edges, int edgesSize, int* edgesColSize) {
    bool** adj = (bool**)malloc(sizeof(bool*) * (n + 1));
    int* degree = (int*)calloc(n + 1, sizeof(int));

    for (int i = 0; i <= n; ++i) {
        adj[i] = (bool*)calloc(n + 1, sizeof(bool));
    }

    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][v] = true;
        adj[v][u] = true;
        degree[u]++;
        degree[v]++;
    }

    int min_degree = INT_MAX;

    for (int i = 1; i <= n; ++i) {
        for (int j = i + 1; j <= n; ++j) {
            if (adj[i][j]) {
                for (int k = j + 1; k <= n; ++k) {
                    if (adj[i][k] && adj[j][k]) {
                        int current_degree = degree[i] + degree[j] + degree[k] - 6;
                        if (current_degree < min_degree) {
                            min_degree = current_degree;
                        }
                    }
                }
            }
        }
    }

    for (int i = 0; i <= n; ++i) {
        free(adj[i]);
    }
    free(adj);
    free(degree);

    return (min_degree == INT_MAX) ? -1 : min_degree;
}