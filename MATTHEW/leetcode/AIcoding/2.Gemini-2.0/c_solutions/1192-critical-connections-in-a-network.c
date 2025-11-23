#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100000

int disc[MAXN], low[MAXN], parent[MAXN];
int timer;
int *adj[MAXN];
int adj_size[MAXN];
int adj_capacity[MAXN];
int **result;
int result_size;
int n;

void addEdge(int u, int v) {
    if (adj_size[u] == adj_capacity[u]) {
        adj_capacity[u] *= 2;
        adj[u] = (int *)realloc(adj[u], adj_capacity[u] * sizeof(int));
    }
    adj[u][adj_size[u]++] = v;
}

void dfs(int u) {
    disc[u] = low[u] = timer++;
    for (int i = 0; i < adj_size[u]; i++) {
        int v = adj[u][i];
        if (disc[v] == -1) {
            parent[v] = u;
            dfs(v);
            low[u] = (low[u] < low[v]) ? low[u] : low[v];
            if (low[v] > disc[u]) {
                result[result_size] = (int *)malloc(2 * sizeof(int));
                result[result_size][0] = u;
                result[result_size][1] = v;
                result_size++;
            }
        } else if (v != parent[u]) {
            low[u] = (low[u] < disc[v]) ? low[u] : disc[v];
        }
    }
}

int** criticalConnections(int n_val, int** connections, int connectionsSize, int* connectionsColSize, int* returnSize, int** returnColumnSizes) {
    n = n_val;
    for (int i = 0; i < n; i++) {
        adj[i] = (int *)malloc(2 * sizeof(int));
        adj_size[i] = 0;
        adj_capacity[i] = 2;
        disc[i] = -1;
        parent[i] = -1;
    }

    for (int i = 0; i < connectionsSize; i++) {
        addEdge(connections[i][0], connections[i][1]);
        addEdge(connections[i][1], connections[i][0]);
    }

    timer = 0;
    result_size = 0;
    result = (int **)malloc(connectionsSize * sizeof(int *));

    for (int i = 0; i < n; i++) {
        if (disc[i] == -1) {
            dfs(i);
        }
    }

    *returnSize = result_size;
    *returnColumnSizes = (int *)malloc(result_size * sizeof(int));
    for (int i = 0; i < result_size; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    return result;
}