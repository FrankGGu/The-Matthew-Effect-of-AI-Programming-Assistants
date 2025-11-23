#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100005

typedef struct Edge {
    int to;
    long long weight;
    struct Edge* next;
} Edge;

Edge* adj[MAXN];

void addEdge(int u, int v, long long w) {
    Edge* newEdge = (Edge*)malloc(sizeof(Edge));
    newEdge->to = v;
    newEdge->weight = w;
    newEdge->next = adj[u];
    adj[u] = newEdge;
}

long long max(long long a, long long b) {
    return (a > b) ? a : b;
}

long long solve(int n, int** edges, int edgesSize, int* edgesColSize) {
    for (int i = 1; i <= n; i++) {
        adj[i] = NULL;
    }

    for (int i = 0; i < edgesSize; i++) {
        addEdge(edges[i][0], edges[i][1], edges[i][2]);
        addEdge(edges[i][1], edges[i][0], edges[i][2]);
    }

    long long maxSum = 0;
    for (int i = 1; i <= n; i++) {
        long long currentSum = 0;
        int count = 0;
        Edge* curr = adj[i];
        while (curr != NULL) {
            currentSum += curr->weight;
            count++;
            curr = curr->next;
        }
        if (count > 0) {
            maxSum = max(maxSum, currentSum);
        }
    }

    return maxSum;
}