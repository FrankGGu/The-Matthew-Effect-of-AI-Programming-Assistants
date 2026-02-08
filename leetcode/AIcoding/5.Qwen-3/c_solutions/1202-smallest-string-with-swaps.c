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

char* smallestStringWithSwaps(char* s, int** pairs, int pairsSize, int* pairsColSize) {
    int n = strlen(s);
    UnionFind* uf = createUnionFind(n);
    for (int i = 0; i < pairsSize; i++) {
        int u = pairs[i][0];
        int v = pairs[i][1];
        unionSet(uf, u, v);
    }

    char** groups = (char**)malloc(n * sizeof(char*));
    int* groupSizes = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        int root = find(uf, i);
        groupSizes[root]++;
    }

    for (int i = 0; i < n; i++) {
        int root = find(uf, i);
        groups[root] = (char*)malloc((groupSizes[root] + 1) * sizeof(char));
    }

    for (int i = 0; i < n; i++) {
        int root = find(uf, i);
        groups[root][groupSizes[root] - 1] = s[i];
        groupSizes[root]--;
    }

    for (int i = 0; i < n; i++) {
        int root = find(uf, i);
        int size = groupSizes[root];
        qsort(groups[root], size, sizeof(char), (int(*)(const void*, const void*))strcmp);
    }

    char* result = (char*)malloc((n + 1) * sizeof(char));
    for (int i = 0; i < n; i++) {
        int root = find(uf, i);
        result[i] = groups[root][groupSizes[root]++];
    }
    result[n] = '\0';

    for (int i = 0; i < n; i++) {
        free(groups[i]);
    }
    free(groups);
    free(groupSizes);
    free(uf->parent);
    free(uf->rank);
    free(uf);

    return result;
}