#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int to;
    int cost;
} Edge;

int compare(const void *a, const void *b) {
    return ((Edge *)a)->cost - ((Edge *)b)->cost;
}

int minCost(int n, int* roads, int roadsSize, int k) {
    Edge** adj = (Edge **)malloc(n * sizeof(Edge *));
    for (int i = 0; i < n; i++) {
        adj[i] = NULL;
    }

    for (int i = 0; i < roadsSize; i += 3) {
        int u = roads[i];
        int v = roads[i + 1];
        int cost = roads[i + 2];
        Edge* e1 = (Edge *)malloc(sizeof(Edge));
        e1->to = v;
        e1->cost = cost;
        Edge* e2 = (Edge *)malloc(sizeof(Edge));
        e2->to = u;
        e2->cost = cost;
        adj[u] = (Edge *)realloc(adj[u], (sizeof(Edge) * (adj[u] ? (size_t)(strlen((char *)adj[u]) + 1) : 1)));
        adj[v] = (Edge *)realloc(adj[v], (sizeof(Edge) * (adj[v] ? (size_t)(strlen((char *)adj[v]) + 1) : 1)));
        adj[u][strlen((char *)adj[u])] = *e1;
        adj[v][strlen((char *)adj[v])] = *e2;
    }

    int* dist = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[0] = 0;

    Edge** pq = (Edge **)malloc(n * sizeof(Edge *));
    int pqSize = 0;
    pq[pqSize++] = (Edge *)malloc(sizeof(Edge));
    pq[0]->to = 0;
    pq[0]->cost = 0;

    while (pqSize > 0) {
        qsort(pq, pqSize, sizeof(Edge *), compare);
        Edge* curr = pq[0];
        pq[0] = pq[--pqSize];
        if (curr->to == n - 1) break;
        if (curr->cost > dist[curr->to]) continue;
        for (int i = 0; adj[curr->to][i].to != -1; i++) {
            Edge* e = &adj[curr->to][i];
            if (dist[curr->to] + e->cost < dist[e->to]) {
                dist[e->to] = dist[curr->to] + e->cost;
                Edge* newEdge = (Edge *)malloc(sizeof(Edge));
                newEdge->to = e->to;
                newEdge->cost = dist[e->to];
                pq[pqSize++] = newEdge;
            }
        }
    }

    int result = dist[n - 1];
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(dist);
    for (int i = 0; i < pqSize; i++) {
        free(pq[i]);
    }
    free(pq);
    return result;
}