#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minReorder(int n, int** connections, int connectionsSize, int* connectionsColSize) {
    int count = 0;
    int* visited = (int*)calloc(n, sizeof(int));
    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(2 * n * sizeof(int));
        for (int j = 0; j < 2 * n; j++) {
            adj[i][j] = -1;
        }
    }

    int* adj_sizes = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < connectionsSize; i++) {
        int u = connections[i][0];
        int v = connections[i][1];
        adj[u][adj_sizes[u]++] = v;
        adj[u][adj_sizes[u]++] = 1; 
        adj[v][adj_sizes[v]++] = u;
        adj[v][adj_sizes[v]++] = 0;
    }

    int stack[n];
    int top = -1;
    stack[++top] = 0;
    visited[0] = 1;

    while (top >= 0) {
        int u = stack[top--];

        for (int i = 0; i < adj_sizes[u]; i += 2) {
            int v = adj[u][i];
            int dir = adj[u][i+1];

            if (!visited[v]) {
                visited[v] = 1;
                stack[++top] = v;
                count += dir;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adj_sizes);
    free(visited);

    return count;
}