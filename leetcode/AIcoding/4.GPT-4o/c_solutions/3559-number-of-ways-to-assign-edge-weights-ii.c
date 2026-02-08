#include <stdio.h>
#include <stdlib.h>

#define MOD 1000000007

typedef struct {
    int x, y, z;
} Edge;

int find(int *parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSets(int *parent, int *rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
}

int numberOfWays(int n, int **edges, int edgesSize, int *edgesColSize) {
    long long ways = 1;
    int *parent = (int *)malloc(n * sizeof(int));
    int *rank = (int *)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1], w = edges[i][2];
        unionSets(parent, rank, u, v);
    }

    for (int i = 0; i < n; i++) {
        if (parent[i] == i) {
            ways = (ways * 2) % MOD;
        }
    }

    free(parent);
    free(rank);
    return (int)ways;
}