#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int u, v, w;
} Edge;

int compare(const void *a, const void *b) {
    return ((Edge *)a)->w - ((Edge *)b)->w;
}

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
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
}

int canAchieve(int mid, int n, Edge *edges, int e) {
    int *parent = (int *)malloc(n * sizeof(int));
    int *rank = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }
    int count = 0;
    for (int i = 0; i < e; i++) {
        if (edges[i].w <= mid) {
            unionSets(parent, rank, edges[i].u, edges[i].v);
        }
    }
    int root = find(parent, 0);
    for (int i = 1; i < n; i++) {
        if (find(parent, i) != root) {
            count++;
        }
    }
    free(parent);
    free(rank);
    return count == 0;
}

int minimizeMax(int **edgesArr, int edgesSize, int n) {
    Edge *edges = (Edge *)malloc(edgesSize * sizeof(Edge));
    for (int i = 0; i < edgesSize; i++) {
        edges[i].u = edgesArr[i][0];
        edges[i].v = edgesArr[i][1];
        edges[i].w = edgesArr[i][2];
    }
    qsort(edges, edgesSize, sizeof(Edge), compare);

    int left = 0, right = edges[edgesSize - 1].w, result = right;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (canAchieve(mid, n, edges, edgesSize)) {
            result = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    free(edges);
    return result;
}