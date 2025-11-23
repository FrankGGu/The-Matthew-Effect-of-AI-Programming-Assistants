#include <stdbool.h>
#include <stdlib.h>

static int* parent;
static int* ranks;

static int find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent[i]);
}

static void unite(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);

    if (root_i != root_j) {
        if (ranks[root_i] < ranks[root_j]) {
            parent[root_i] = root_j;
        } else if (ranks[root_j] < ranks[root_i]) {
            parent[root_j] = root_i;
        } else {
            parent[root_j] = root_i;
            ranks[root_i]++;
        }
    }
}

static int compareEdges(const void* a, const void* b) {
    const int* edgeA = *(const int**)a;
    const int* edgeB = *(const int**)b;
    return edgeA[2] - edgeB[2];
}

typedef struct {
    int u;
    int v;
    int limit;
    int original_index;
} QueryData;

static int compareQueries(const void* a, const void* b) {
    const QueryData* queryA = (const QueryData*)a;
    const QueryData* queryB = (const QueryData*)b;
    return queryA->limit - queryB->limit;
}

bool* distanceLimitedPathsExist(int n, int** edgeList, int edgeListSize, int* edgeListColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    parent = (int*)malloc(n * sizeof(int));
    ranks = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        parent[i] = i;
        ranks[i] = 0;
    }

    qsort(edgeList, edgeListSize, sizeof(int*), compareEdges);

    QueryData* augmentedQueries = (QueryData*)malloc(queriesSize * sizeof(QueryData));
    for (int i = 0; i < queriesSize; i++) {
        augmentedQueries[i].u = queries[i][0];
        augmentedQueries[i].v = queries[i][1];
        augmentedQueries[i].limit = queries[i][2];
        augmentedQueries[i].original_index = i;
    }
    qsort(augmentedQueries, queriesSize, sizeof(QueryData), compareQueries);

    bool* ans = (bool*)malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    int edge_idx = 0;
    for (int i = 0; i < queriesSize; i++) {
        int u = augmentedQueries[i].u;
        int v = augmentedQueries[i].v;
        int limit = augmentedQueries[i].limit;
        int original_index = augmentedQueries[i].original_index;

        while (edge_idx < edgeListSize && edgeList[edge_idx][2] < limit) {
            unite(edgeList[edge_idx][0], edgeList[edge_idx][1]);
            edge_idx++;
        }

        ans[original_index] = (find(u) == find(v));
    }

    free(parent);
    free(ranks);
    free(augmentedQueries);

    return ans;
}