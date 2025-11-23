#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 10000
#define MAXQ 10000

typedef struct Edge {
    int to;
    int weight;
    int next;
} Edge;

Edge edges[2 * MAXN];
int head[MAXN];
int edge_count = 0;

int depth[MAXN];
int parent[MAXN][15];
int weightSum[MAXN][64];

void add_edge(int u, int v, int w) {
    edges[edge_count].to = v;
    edges[edge_count].weight = w;
    edges[edge_count].next = head[u];
    head[u] = edge_count++;
}

void dfs(int u, int p, int d, int weight) {
    depth[u] = d;
    parent[u][0] = p;
    if (p != -1) {
        for (int i = 0; i < 64; i++) {
            weightSum[u][i] = weightSum[p][i];
        }
        weightSum[u][weight - 1]++;
    }

    for (int i = head[u]; i != -1; i = edges[i].next) {
        int v = edges[i].to;
        int w = edges[i].weight;
        if (v != p) {
            dfs(v, u, d + 1, w);
        }
    }
}

int lca(int u, int v) {
    if (depth[u] < depth[v]) {
        int temp = u;
        u = v;
        v = temp;
    }

    int diff = depth[u] - depth[v];
    for (int i = 14; i >= 0; i--) {
        if ((diff >> i) & 1) {
            u = parent[u][i];
        }
    }

    if (u == v) {
        return u;
    }

    for (int i = 14; i >= 0; i--) {
        if (parent[u][i] != parent[v][i]) {
            u = parent[u][i];
            v = parent[v][i];
        }
    }

    return parent[u][0];
}

int maxWeight(int u, int v) {
    int ancestor = lca(u, v);
    int counts[64] = {0};
    for (int i = 0; i < 64; i++) {
        counts[i] = weightSum[u][i] + weightSum[v][i] - weightSum[ancestor][i];
        if (parent[ancestor][0] != -1) {
            counts[i] -= weightSum[parent[ancestor][0]][i];
        }
    }

    int max_count = 0;
    for (int i = 0; i < 64; i++) {
        if (counts[i] > max_count) {
            max_count = counts[i];
        }
    }

    return depth[u] + depth[v] - 2 * depth[ancestor] - max_count;
}

int* minEdgeWeightEquilibriumQueries(int n, int** edges_in, int edges_size, int* edgesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    for (int i = 0; i < n; i++) {
        head[i] = -1;
    }
    edge_count = 0;

    for (int i = 0; i < edges_size; i++) {
        int u = edges_in[i][0];
        int v = edges_in[i][1];
        int w = edges_in[i][2];
        add_edge(u, v, w);
        add_edge(v, u, w);
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < 15; j++) {
            parent[i][j] = -1;
        }
        for (int j = 0; j < 64; j++) {
            weightSum[i][j] = 0;
        }
    }

    dfs(0, -1, 0, 0);

    for (int j = 1; j < 15; j++) {
        for (int i = 0; i < n; i++) {
            if (parent[i][j - 1] != -1) {
                parent[i][j] = parent[parent[i][j - 1]][j - 1];
            }
        }
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;
    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];
        result[i] = maxWeight(u, v);
    }

    return result;
}