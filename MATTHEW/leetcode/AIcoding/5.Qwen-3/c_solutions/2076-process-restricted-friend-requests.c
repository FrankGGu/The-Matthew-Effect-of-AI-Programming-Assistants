#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct UnionFind {
    int *parent;
    int *rank;
    int size;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind *uf = (UnionFind*)malloc(sizeof(UnionFind));
    uf->parent = (int*)malloc(n * sizeof(int));
    uf->rank = (int*)malloc(n * sizeof(int));
    uf->size = n;
    for (int i = 0; i < n; i++) {
        uf->parent[i] = i;
        uf->rank[i] = 1;
    }
    return uf;
}

int find(UnionFind *uf, int x) {
    if (uf->parent[x] != x) {
        uf->parent[x] = find(uf, uf->parent[x]);
    }
    return uf->parent[x];
}

void unionSet(UnionFind *uf, int x, int y) {
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

int* friendRequests(int n, int* restrictions, int restrictionsSize, int** requests, int requestsSize, int* requestsColSize, int* returnSize) {
    UnionFind *uf = createUnionFind(n);
    int *result = (int*)malloc(requestsSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < requestsSize; i++) {
        int u = requests[i][0];
        int v = requests[i][1];
        int rootU = find(uf, u);
        int rootV = find(uf, v);
        int canRequest = 1;

        for (int j = 0; j < restrictionsSize; j += 2) {
            int a = restrictions[j];
            int b = restrictions[j + 1];
            int rootA = find(uf, a);
            int rootB = find(uf, b);
            if ((rootA == rootU && rootB == rootV) || (rootA == rootV && rootB == rootU)) {
                canRequest = 0;
                break;
            }
        }

        if (canRequest) {
            unionSet(uf, u, v);
            result[count++] = 1;
        } else {
            result[count++] = 0;
        }
    }

    *returnSize = count;
    return result;
}