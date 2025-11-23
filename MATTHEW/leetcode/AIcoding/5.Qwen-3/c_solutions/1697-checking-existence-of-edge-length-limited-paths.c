#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int u;
    int v;
    int idx;
} Edge;

int compareEdges(const void* a, const void* b) {
    Edge* e1 = (Edge*)a;
    Edge* e2 = (Edge*)b;
    return e1->idx - e2->idx;
}

int find(int x, int* parent) {
    if (parent[x] != x) {
        parent[x] = find(parent[x], parent);
    }
    return parent[x];
}

void unionSet(int x, int y, int* parent, int* rank) {
    int rootX = find(x, parent);
    int rootY = find(y, parent);
    if (rootX != rootY) {
        if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootX] = rootY;
            if (rank[rootX] == rank[rootY]) {
                rank[rootY]++;
            }
        }
    }
}

bool* edgeLimitedPaths(int n, int** edges, int edgesSize, int* queries, int queriesSize, int* returnSize) {
    Edge* edgeList = (Edge*)malloc(edgesSize * sizeof(Edge));
    for (int i = 0; i < edgesSize; i++) {
        edgeList[i].u = edges[i][0];
        edgeList[i].v = edges[i][1];
        edgeList[i].idx = i;
    }

    qsort(edgeList, edgesSize, sizeof(Edge), compareEdges);

    int* parent = (int*)malloc(n * sizeof(int));
    int* rank = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; i++) {
        result[i] = false;
    }

    int edgeIdx = 0;
    for (int i = 0; i < queriesSize; i++) {
        int limit = queries[i];
        while (edgeIdx < edgesSize && edgeList[edgeIdx].idx < limit) {
            unionSet(edgeList[edgeIdx].u, edgeList[edgeIdx].v, parent, rank);
            edgeIdx++;
        }
        int u = queries[i + 1];
        int v = queries[i + 2];
        if (find(u, parent) == find(v, parent)) {
            result[i] = true;
        }
        i += 2;
    }

    *returnSize = queriesSize;
    free(edgeList);
    free(parent);
    free(rank);
    return result;
}