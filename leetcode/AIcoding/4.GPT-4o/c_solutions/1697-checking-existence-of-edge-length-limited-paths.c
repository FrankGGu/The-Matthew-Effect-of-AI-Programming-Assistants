#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int u, v, w;
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

void unionSet(int *parent, int *rank, int x, int y) {
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

bool[] distanceLimitedPathsExist(int n, int** edgeList, int edgeListSize, int** queries, int queriesSize, int* queriesColSize) {
    bool *result = (bool *)malloc(queriesSize * sizeof(bool));
    Edge *edges = (Edge *)malloc(edgeListSize * sizeof(Edge));
    for (int i = 0; i < edgeListSize; i++) {
        edges[i].u = edgeList[i][0];
        edges[i].v = edgeList[i][1];
        edges[i].w = edgeList[i][2];
    }

    qsort(edges, edgeListSize, sizeof(Edge), cmp);

    int **indexedQueries = (int **)malloc(queriesSize * sizeof(int *));
    for (int i = 0; i < queriesSize; i++) {
        indexedQueries[i] = (int *)malloc(4 * sizeof(int));
        indexedQueries[i][0] = queries[i][0];
        indexedQueries[i][1] = queries[i][1];
        indexedQueries[i][2] = queries[i][2];
        indexedQueries[i][3] = i;
    }

    qsort(indexedQueries, queriesSize, sizeof(int *), cmp);

    int *parent = (int *)malloc(n * sizeof(int));
    int *rank = (int *)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }

    int edgeIndex = 0;
    for (int i = 0; i < queriesSize; i++) {
        while (edgeIndex < edgeListSize && edges[edgeIndex].w < indexedQueries[i][2]) {
            unionSet(parent, rank, edges[edgeIndex].u, edges[edgeIndex].v);
            edgeIndex++;
        }
        result[indexedQueries[i][3]] = find(parent, indexedQueries[i][0]) == find(parent, indexedQueries[i][1]);
    }

    for (int i = 0; i < queriesSize; i++) {
        free(indexedQueries[i]);
    }
    free(indexedQueries);
    free(edges);
    free(parent);
    free(rank);

    return result;
}