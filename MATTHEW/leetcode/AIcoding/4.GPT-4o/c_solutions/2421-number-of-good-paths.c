#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int val;
    int rank;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind* uf = (UnionFind*)malloc(sizeof(UnionFind) * n);
    for (int i = 0; i < n; i++) {
        uf[i].val = i;
        uf[i].rank = 1;
    }
    return uf;
}

int find(UnionFind* uf, int x) {
    if (uf[x].val != x) {
        uf[x].val = find(uf, uf[x].val);
    }
    return uf[x].val;
}

void unionSet(UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        if (uf[rootX].rank > uf[rootY].rank) {
            uf[rootY].val = rootX;
        } else if (uf[rootX].rank < uf[rootY].rank) {
            uf[rootX].val = rootY;
        } else {
            uf[rootY].val = rootX;
            uf[rootX].rank++;
        }
    }
}

int numberOfGoodPaths(int* vals, int valsSize, int** edges, int edgesSize, int* edgesColSize) {
    int n = valsSize;
    int result = 0;
    int* counts = (int*)calloc(n, sizeof(int));
    int** adj = (int**)calloc(n, sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(sizeof(int) * (edgesSize * 2));
    }

    for (int i = 0; i < edgesSize; i++) {
        adj[edges[i][0]][counts[edges[i][0]]++] = edges[i][1];
        adj[edges[i][1]][counts[edges[i][1]]++] = edges[i][0];
    }

    int* sortedIndices = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        sortedIndices[i] = i;
    }
    qsort(sortedIndices, n, sizeof(int), cmp);

    UnionFind* uf = createUnionFind(n);
    int* groupCount = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        int u = sortedIndices[i];
        groupCount[u] = 1;

        for (int j = 0; j < counts[u]; j++) {
            int v = adj[u][j];
            if (vals[u] >= vals[v]) {
                unionSet(uf, u, v);
            }
        }
    }

    for (int i = 0; i < n; i++) {
        int root = find(uf, i);
        groupCount[root]++;
    }

    for (int i = 0; i < n; i++) {
        int count = groupCount[i];
        result += count * (count + 1) / 2;
    }

    free(counts);
    free(groupCount);
    free(sortedIndices);
    free(uf);
    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);

    return result;
}

int cmp(const void* a, const void* b) {
    return vals[*(int*)a] - vals[*(int*)b];
}