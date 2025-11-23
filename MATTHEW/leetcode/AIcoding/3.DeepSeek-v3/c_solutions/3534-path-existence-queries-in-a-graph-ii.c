#include <stdlib.h>
#include <string.h>

typedef struct {
    int* parent;
    int* rank;
} DSU;

DSU* createDSU(int n) {
    DSU* dsu = (DSU*)malloc(sizeof(DSU));
    dsu->parent = (int*)malloc(n * sizeof(int));
    dsu->rank = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dsu->parent[i] = i;
        dsu->rank[i] = 0;
    }
    return dsu;
}

int find(DSU* dsu, int x) {
    if (dsu->parent[x] != x) {
        dsu->parent[x] = find(dsu, dsu->parent[x]);
    }
    return dsu->parent[x];
}

void unionSets(DSU* dsu, int x, int y) {
    int rootX = find(dsu, x);
    int rootY = find(dsu, y);
    if (rootX != rootY) {
        if (dsu->rank[rootX] < dsu->rank[rootY]) {
            dsu->parent[rootX] = rootY;
        } else if (dsu->rank[rootX] > dsu->rank[rootY]) {
            dsu->parent[rootY] = rootX;
        } else {
            dsu->parent[rootY] = rootX;
            dsu->rank[rootX]++;
        }
    }
}

void freeDSU(DSU* dsu) {
    free(dsu->parent);
    free(dsu->rank);
    free(dsu);
}

int* distanceLimitedPathsExist(int n, int** edgeList, int edgeListSize, int* edgeListColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int** sortedQueries = (int**)malloc(queriesSize * sizeof(int*));
    for (int i = 0; i < queriesSize; i++) {
        sortedQueries[i] = (int*)malloc(4 * sizeof(int));
        sortedQueries[i][0] = queries[i][0];
        sortedQueries[i][1] = queries[i][1];
        sortedQueries[i][2] = queries[i][2];
        sortedQueries[i][3] = i;
    }

    qsort(sortedQueries, queriesSize, sizeof(int*), 
          (int (*)(const void*, const void*))[](const void* a, const void* b) {
              int* q1 = *(int**)a;
              int* q2 = *(int**)b;
              return q1[2] - q2[2];
          });

    qsort(edgeList, edgeListSize, sizeof(int*), 
          (int (*)(const void*, const void*))[](const void* a, const void* b) {
              int* e1 = *(int**)a;
              int* e2 = *(int**)b;
              return e1[2] - e2[2];
          });

    DSU* dsu = createDSU(n);
    int edgeIndex = 0;

    for (int i = 0; i < queriesSize; i++) {
        int u = sortedQueries[i][0];
        int v = sortedQueries[i][1];
        int limit = sortedQueries[i][2];
        int idx = sortedQueries[i][3];

        while (edgeIndex < edgeListSize && edgeList[edgeIndex][2] < limit) {
            unionSets(dsu, edgeList[edgeIndex][0], edgeList[edgeIndex][1]);
            edgeIndex++;
        }

        result[idx] = (find(dsu, u) == find(dsu, v));
    }

    for (int i = 0; i < queriesSize; i++) {
        free(sortedQueries[i]);
    }
    free(sortedQueries);
    freeDSU(dsu);

    return result;
}