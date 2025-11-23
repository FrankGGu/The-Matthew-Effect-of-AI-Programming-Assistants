#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int u, v, w, idx;
} Edge;

int cmp(const void *a, const void *b) {
    return ((Edge *)a)->w - ((Edge *)b)->w;
}

int find(int *parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void union_set(int *parent, int *rank, int x, int y) {
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

int kruskal(Edge *edges, int n, int m, int ignore, int include) {
    int *parent = (int *)malloc(n * sizeof(int));
    int *rank = (int *)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }
    int total_weight = 0, count = 0;

    if (include != -1) {
        total_weight += edges[include].w;
        union_set(parent, rank, edges[include].u, edges[include].v);
        count++;
    }

    for (int i = 0; i < m; i++) {
        if (i == ignore) continue;
        int u = edges[i].u, v = edges[i].v;
        if (find(parent, u) != find(parent, v)) {
            union_set(parent, rank, u, v);
            total_weight += edges[i].w;
            count++;
        }
    }
    free(parent);
    free(rank);
    return count == n - 1 ? total_weight : -1;
}

int** findCriticalAndPseudoCriticalEdges(int n, int edgesSize, int** edges, int* returnSize) {
    Edge *edgeList = (Edge *)malloc(edgesSize * sizeof(Edge));
    for (int i = 0; i < edgesSize; i++) {
        edgeList[i] = (Edge){edges[i][0], edges[i][1], edges[i][2], i};
    }

    qsort(edgeList, edgesSize, sizeof(Edge), cmp);

    int mstWeight = kruskal(edgeList, n, edgesSize, -1, -1);
    int *critical = (int *)malloc(edgesSize * sizeof(int));
    int *pseudoCritical = (int *)malloc(edgesSize * sizeof(int));
    int criticalCount = 0, pseudoCount = 0;

    for (int i = 0; i < edgesSize; i++) {
        if (kruskal(edgeList, n, edgesSize, i, -1) != mstWeight) {
            critical[criticalCount++] = edgeList[i].idx;
        } else if (kruskal(edgeList, n, edgesSize, -1, i) == mstWeight) {
            pseudoCritical[pseudoCount++] = edgeList[i].idx;
        }
    }

    int **result = (int **)malloc(2 * sizeof(int *));
    result[0] = (int *)malloc(criticalCount * sizeof(int));
    result[1] = (int *)malloc(pseudoCount * sizeof(int));

    for (int i = 0; i < criticalCount; i++) {
        result[0][i] = critical[i];
    }
    for (int i = 0; i < pseudoCount; i++) {
        result[1][i] = pseudoCritical[i];
    }

    *returnSize = 2;
    free(edgeList);
    free(critical);
    free(pseudoCritical);

    return result;
}