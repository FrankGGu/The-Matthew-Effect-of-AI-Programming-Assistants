#include <stdio.h>
#include <stdlib.h>

struct UnionFind {
    int *parent;
    int *rank;
    int size;
};

struct UnionFind* createUnionFind(int n) {
    struct UnionFind* uf = (struct UnionFind*)malloc(sizeof(struct UnionFind));
    uf->parent = (int*)malloc(n * sizeof(int));
    uf->rank = (int*)malloc(n * sizeof(int));
    uf->size = n;
    for (int i = 0; i < n; i++) {
        uf->parent[i] = i;
        uf->rank[i] = 0;
    }
    return uf;
}

int find(struct UnionFind* uf, int x) {
    if (uf->parent[x] != x) {
        uf->parent[x] = find(uf, uf->parent[x]);
    }
    return uf->parent[x];
}

void unionSets(struct UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        if (uf->rank[rootX] > uf->rank[rootY]) {
            uf->parent[rootY] = rootX;
        } else if (uf->rank[rootX] < uf->rank[rootY]) {
            uf->parent[rootX] = rootY;
        } else {
            uf->parent[rootY] = rootX;
            uf->rank[rootX]++;
        }
    }
}

void freeUnionFind(struct UnionFind* uf) {
    free(uf->parent);
    free(uf->rank);
    free(uf);
}

int* findAllPeople(int n, int** meetings, int meetingsSize, int* meetingsColSize, int* returnSize) {
    struct UnionFind* uf = createUnionFind(n);
    int* result = (int*)malloc(n * sizeof(int));
    int* temp = (int*)malloc(n * sizeof(int));
    int index = 0;

    qsort(meetings, meetingsSize, sizeof(int*), [](const void* a, const void* b) {
        return (*(int**)a)[2] - (*(int**)b)[2];
    });

    for (int i = 0, j = 0; i < meetingsSize; i = j) {
        while (j < meetingsSize && meetings[i][2] == meetings[j][2]) {
            unionSets(uf, meetings[j][0], meetings[j][1]);
            j++;
        }
        for (int k = i; k < j; k++) {
            if (find(uf, meetings[k][0]) == find(uf, meetings[k][1])) {
                temp[meetings[k][0]] = 1;
                temp[meetings[k][1]] = 1;
            }
        }
        for (int k = 0; k < n; k++) {
            if (temp[k]) {
                unionSets(uf, k, 0);
            }
        }
        memset(temp, 0, n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        if (find(uf, i) == find(uf, 0)) {
            result[index++] = i;
        }
    }

    freeUnionFind(uf);
    *returnSize = index;
    return result;
}