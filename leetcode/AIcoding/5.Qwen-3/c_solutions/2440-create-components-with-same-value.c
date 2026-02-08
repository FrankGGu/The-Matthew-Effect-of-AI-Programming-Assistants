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

int componentValue(int* nums, int numsSize, int** edges, int edgesSize, int* edgesColSize) {
    UnionFind* uf = createUnionFind(numsSize);
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        unionSet(uf, u, v);
    }

    int* rootSum = (int*)calloc(numsSize, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        int root = find(uf, i);
        rootSum[root] += nums[i];
    }

    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        if (uf->parent[i] == i) {
            total += rootSum[i];
        }
    }

    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        if (uf->parent[i] == i) {
            maxVal = fmax(maxVal, rootSum[i]);
        }
    }

    if (total % maxVal != 0) {
        return 0;
    }

    int target = total / maxVal;
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (uf->parent[i] == i && rootSum[i] == maxVal) {
            count++;
        }
    }

    return count;
}