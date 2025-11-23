#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minimumFuelCost(int n, int** roads, int roadsSize, int* roadsColSize, int seats) {
    if (n == 1) return 0;

    int *adj[n];
    int adj_size[n];
    for (int i = 0; i < n; i++) {
        adj_size[i] = 0;
        adj[i] = (int*)malloc(sizeof(int) * n);
    }

    for (int i = 0; i < roadsSize; i++) {
        int u = roads[i][0];
        int v = roads[i][1];

        adj[u][adj_size[u]++] = v;
        adj[v][adj_size[v]++] = u;
    }

    long long total_fuel = 0;
    int *subtree_size = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        subtree_size[i] = 1;
    }

    int *visited = (int*)calloc(n, sizeof(int));

    void dfs(int u) {
        visited[u] = 1;
        for (int i = 0; i < adj_size[u]; i++) {
            int v = adj[u][i];
            if (!visited[v]) {
                dfs(v);
                subtree_size[u] += subtree_size[v];
                total_fuel += (subtree_size[v] + seats - 1) / seats;
            }
        }
    }

    dfs(0);

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(subtree_size);
    free(visited);

    return total_fuel;
}