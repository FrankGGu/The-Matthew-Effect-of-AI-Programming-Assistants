#include <stdbool.h>
#include <stdlib.h>

typedef struct {
    int parent;
    int rank;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind* uf = malloc(sizeof(UnionFind) * (n + 1));
    for (int i = 0; i <= n; i++) {
        uf[i].parent = i;
        uf[i].rank = 0;
    }
    return uf;
}

int find(UnionFind* uf, int x) {
    if (uf[x].parent != x) {
        uf[x].parent = find(uf, uf[x].parent);
    }
    return uf[x].parent;
}

void unionSets(UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);

    if (rootX != rootY) {
        if (uf[rootX].rank > uf[rootY].rank) {
            uf[rootY].parent = rootX;
        } else if (uf[rootX].rank < uf[rootY].rank) {
            uf[rootX].parent = rootY;
        } else {
            uf[rootY].parent = rootX;
            uf[rootX].rank++;
        }
    }
}

bool areConnected(int n, int threshold, int x, int y) {
    UnionFind* uf = createUnionFind(n);

    for (int i = threshold + 1; i <= n; i++) {
        if (i % threshold == 0) {
            unionSets(uf, i, i / threshold);
        }
    }

    bool result = find(uf, x) == find(uf, y);
    free(uf);
    return result;
}