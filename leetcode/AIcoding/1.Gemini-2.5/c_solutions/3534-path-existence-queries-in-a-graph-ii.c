#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

int* parent;
int* sz;

void dsu_init(int n) {
    parent = (int*)malloc((n + 1) * sizeof(int));
    sz = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; ++i) {
        parent[i] = i;
        sz[i] = 1;
    }
}

int dsu_find(int i) {
    if (parent[i] == i) {
        return i;
    }
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

typedef struct {
    int u, v, limit, original_index;
} Query;

int compareEdges(const void* a, const void* b) {
    return ((Edge*)a)->weight - ((Edge*)b)->weight;
}

int compareQueries(const void* a, const void* b) {
    return ((Query*)a)->limit - ((Query*)b)->limit;
}

bool* distanceLimitedPathsExist(int n, int** edgeList, int edgeListSize, int* edgeListColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    bool* results = (bool*)malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    Edge* edges = (Edge*)malloc(edgeListSize * sizeof(Edge));
    for (int i = 0; i < edgeListSize; ++i) {
        edges[i].u = edgeList[i][0];
        edges[i].v = edgeList[i][1];
        edges[i].weight = edgeList[i][2];
    }

    Query* query_objs = (Query*)malloc(queriesSize * sizeof(Query));
    for (int i = 0; i < queriesSize; ++i) {
        query_objs[i].u = queries[i][0];
        query_objs[i].v = queries[i][1];
        query_objs[i].limit = queries[i][2];
        query_objs[i].original_index = i;
    }

    qsort(edges, edgeListSize, sizeof(Edge), compareEdges);
    qsort(query_objs, queriesSize, sizeof(Query), compareQueries);

    dsu_init(n);

    int edge_idx = 0;
    for (int i = 0; i < queriesSize; ++i) {
        Query current_query = query_objs[i];

        while (edge_idx < edgeListSize && edges[edge_idx].weight < current_query.limit) {
            dsu_unite(edges[edge_idx].u, edges[edge_idx].v);
            edge_idx++;
        }

        results[current_query.original_index] = (dsu_find(current_query.u) == dsu_find(current_query.v));
    }

    free(parent);
    free(sz);
    free(edges);
    free(query_objs);

    return results;
}