#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* parent;
    int* rank;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind* uf = (UnionFind*)malloc(sizeof(UnionFind));
    uf->parent = (int*)malloc(n * sizeof(int));
    uf->rank = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        uf->parent[i] = i;
        uf->rank[i] = 1;
    }
    return uf;
}

int find(UnionFind* uf, int x) {
    if (uf->parent[x] != x) {
        uf->parent[x] = find(uf, uf->parent[x]);
    }
    return uf->parent[x];
}

void unionSet(UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        if (uf->rank[rootX] > uf->rank[rootY]) {
            uf->parent[rootY] = rootX;
        } else {
            uf->parent[rootX] = rootY;
            if (uf->rank[rootX] == uf->rank[rootY]) {
                uf->rank[rootY]++;
            }
        }
    }
}

int numberOfGoodPaths(int* nums, int numsSize, int** edges, int edgesSize, int* edgesColSize) {
    int n = numsSize;
    UnionFind* uf = createUnionFind(n);
    int* count = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        count[i] = 1;
    }

    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(0);
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u] = (int*)realloc(adj[u], (sizeof(int) * (strlen((char*)adj[u]) + 1)));
        adj[u][strlen((char*)adj[u])] = v;
        adj[v] = (int*)realloc(adj[v], (sizeof(int) * (strlen((char*)adj[v]) + 1)));
        adj[v][strlen((char*)adj[v])] = u;
    }

    int* sortedNums = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        sortedNums[i] = nums[i];
    }

    qsort(sortedNums, n, sizeof(int), (int (*)(const void*, const void*))strcmp);

    int* indexMap = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        indexMap[i] = i;
    }

    qsort(indexMap, n, sizeof(int), (int (*)(const void*, const void*))strcmp);

    for (int i = 0; i < n; i++) {
        int node = indexMap[i];
        int val = nums[node];
        for (int j = 0; j < strlen((char*)adj[node]); j++) {
            int neighbor = adj[node][j];
            if (nums[neighbor] <= val) {
                unionSet(uf, node, neighbor);
            }
        }
    }

    int result = 0;
    for (int i = 0; i < n; i++) {
        int root = find(uf, i);
        if (nums[i] == nums[root]) {
            result++;
        }
    }

    free(count);
    free(uf->parent);
    free(uf->rank);
    free(uf);
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(sortedNums);
    free(indexMap);

    return result;
}