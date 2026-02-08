#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int parent;
    int rank;
} UF;

int find(UF *uf, int i) {
    if (uf[i].parent != i) {
        uf[i].parent = find(uf, uf[i].parent);
    }
    return uf[i].parent;
}

void union_sets(UF *uf, int i, int j) {
    int root_i = find(uf, i);
    int root_j = find(uf, j);
    if (root_i != root_j) {
        if (uf[root_i].rank < uf[root_j].rank) {
            uf[root_i].parent = root_j;
        } else if (uf[root_i].rank > uf[root_j].rank) {
            uf[root_j].parent = root_i;
        } else {
            uf[root_j].parent = root_i;
            uf[root_i].rank++;
        }
    }
}

int compare(const void *a, const void *b) {
    return ((int*)a)[2] - ((int*)b)[2];
}

int compare_queries(const void *a, const void *b) {
    return ((int*)a)[2] - ((int*)b)[2];
}

bool* distanceLimitedPathsExist(int n, int** edgeList, int edgeListSize, int* edgeListColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    UF uf[n];
    for (int i = 0; i < n; i++) {
        uf[i].parent = i;
        uf[i].rank = 0;
    }

    int* query_indices[queriesSize];
    int modified_queries[queriesSize][4];

    for(int i = 0; i < queriesSize; i++){
        modified_queries[i][0] = queries[i][0];
        modified_queries[i][1] = queries[i][1];
        modified_queries[i][2] = queries[i][2];
        modified_queries[i][3] = i;
        query_indices[i] = modified_queries[i];
    }

    qsort(edgeList, edgeListSize, sizeof(edgeList[0]), compare);
    qsort(query_indices, queriesSize, sizeof(int*), compare_queries);

    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    int edge_index = 0;
    for (int i = 0; i < queriesSize; i++) {
        int p = query_indices[i][0];
        int q = query_indices[i][1];
        int limit = query_indices[i][2];
        int original_index = query_indices[i][3];

        while (edge_index < edgeListSize && edgeList[edge_index][2] < limit) {
            union_sets(uf, edgeList[edge_index][0], edgeList[edge_index][1]);
            edge_index++;
        }

        result[original_index] = (find(uf, p) == find(uf, q));
    }

    return result;
}