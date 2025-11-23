#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100005

int n;
typedef struct Edge {
    int to;
    int reversed;
    struct Edge* next;
} Edge;

Edge* adj[MAXN];
int ans[MAXN];

void addEdge(int u, int v, int reversed) {
    Edge* edge = (Edge*)malloc(sizeof(Edge));
    edge->to = v;
    edge->reversed = reversed;
    edge->next = adj[u];
    adj[u] = edge;
}

int dfs1(int u, int parent) {
    int count = 0;
    for (Edge* edge = adj[u]; edge != NULL; edge = edge->next) {
        int v = edge->to;
        if (v != parent) {
            count += dfs1(v, u) + edge->reversed;
        }
    }
    return count;
}

void dfs2(int u, int parent) {
    for (Edge* edge = adj[u]; edge != NULL; edge = edge->next) {
        int v = edge->to;
        if (v != parent) {
            ans[v] = ans[u] + (edge->reversed == 0 ? 1 : -1);
            dfs2(v, u);
        }
    }
}

int* minEdgeReversals(int n_in, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    n = n_in;

    for (int i = 0; i < n; i++) {
        adj[i] = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        addEdge(u, v, 0);
        addEdge(v, u, 1);
    }

    ans[0] = dfs1(0, -1);
    dfs2(0, -1);

    int* result = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        result[i] = ans[i];
    }

    *returnSize = n;
    return result;
}