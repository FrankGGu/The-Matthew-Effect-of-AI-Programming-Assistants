#include <stdio.h>
#include <stdlib.h>

#define MAXN 1000

int graph[MAXN][MAXN];
int deg[MAXN];

int minTrioDegree(int n, int** edges, int edgesSize, int* edgesColSize) {
    for (int i = 0; i < n; i++) {
        deg[i] = 0;
        for (int j = 0; j < n; j++) {
            graph[i][j] = 0;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0] - 1;
        int v = edges[i][1] - 1;
        graph[u][v] = graph[v][u] = 1;
        deg[u]++;
        deg[v]++;
    }

    int min_degree = MAXN * 3;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (graph[i][j]) {
                for (int k = j + 1; k < n; k++) {
                    if (graph[i][k] && graph[j][k]) {
                        int total_degree = deg[i] + deg[j] + deg[k] - 6;
                        if (total_degree < min_degree) {
                            min_degree = total_degree;
                        }
                    }
                }
            }
        }
    }

    return min_degree == MAXN * 3 ? -1 : min_degree;
}