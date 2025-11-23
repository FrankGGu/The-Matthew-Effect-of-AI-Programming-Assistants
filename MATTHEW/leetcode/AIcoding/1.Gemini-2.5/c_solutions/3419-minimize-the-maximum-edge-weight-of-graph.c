#include <stdlib.h>

int* parent;
int* sz;

void dsu_init(int n) {
    parent = (int*)malloc(sizeof(int) * n);
    sz = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; ++i) {
        parent[i] = i;
        sz[i] = 1;
    }
}

int dsu_find(int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = dsu_find(parent[i]);
}

void dsu_unite(int i, int j) {
    int root_i = dsu_find(i);
    int root_j = dsu_find(j);
    if (root_i != root_j) {
        if (sz[root_i] < sz[root_j]) {
            int temp = root_i;
            root_i = root_j;
            root_j = temp;
        }
        parent[root_j] = root_i;
        sz[root_i] += sz[root_j];
    }
}

typedef struct {
    int u, v, weight;
} Edge;

int compareEdges(const void* a, const void* b) {
    return ((Edge*)a)->weight - ((Edge*)b)->weight;
}

int minMaxWeight(int n, int** edges, int edgesSize, int* edgesColSize) {
    Edge* edgeList = (Edge*)malloc(sizeof(Edge) * edgesSize);
    for (int i = 0; i < edgesSize; ++i) {
        edgeList[i].u = edges[i][0];
        edgeList[i].v = edges[i][1];
        edgeList[i].weight = edges[i][2];
    }

    qsort(edgeList, edgesSize, sizeof(Edge), compareEdges);

    dsu_init(n);

    int max_weight_in_mst = 0;
    int edges_in_mst_count = 0;

    for (int i = 0; i < edgesSize; ++i) {
        int u = edgeList[i].u;
        int v = edgeList[i].v;
        int w = edgeList[i].weight;

        if (dsu_find(u) != dsu_find(v)) {
            dsu_unite(u, v);
            max_weight_in_mst = w;
            edges_in_mst_count++;
            if (edges_in_mst_count == n - 1) {
                break;
            }
        }
    }

    free(parent);
    free(sz);
    free(edgeList);

    return max_weight_in_mst;
}