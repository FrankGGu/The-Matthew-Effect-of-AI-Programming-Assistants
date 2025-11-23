#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int u, v, w;
} Edge;

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unite(int parent[], int rank[], int x, int y) {
    x = find(parent, x);
    y = find(parent, y);

    if (x != y) {
        if (rank[x] < rank[y])
            parent[x] = y;
        else if (rank[x] > rank[y])
            parent[y] = x;
        else {
            parent[y] = x;
            rank[x]++;
        }
    }
}

bool isPossible(int n, int[][] edges, int maxWeight, int k) {
    int parent[n + 1];
    int rank[n + 1];
    for (int i = 1; i <= n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int components = n;
    for (int i = 0; i < edges.length; i++) {
        if (edges[i][2] <= maxWeight) {
            int u = edges[i][0];
            int v = edges[i][1];
            if (find(parent, u) != find(parent, v)) {
                unite(parent, rank, u, v);
                components--;
            }
        }
    }

    return components <= k;
}

int minimizeMaximumEdgeWeight(int n, int[][] edges, int k) {
    int low = 1, high = 1000000000;
    int result = -1;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (isPossible(n, edges, mid, k)) {
            result = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return result;
}