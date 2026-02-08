#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int parent;
    int rank;
} UnionFind;

UnionFind* createUnionFind(int size) {
    UnionFind* uf = (UnionFind*)malloc(sizeof(UnionFind) * size);
    for (int i = 0; i < size; i++) {
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

int maxNumEdgesToRemove(int n, int** edges, int edgesSize, int* edgesColSize) {
    UnionFind* ufA = createUnionFind(n + 1);
    UnionFind* ufB = createUnionFind(n + 1);
    int usedEdges = 0;

    for (int i = 0; i < edgesSize; i++) {
        if (edges[i][0] == 3) {
            if (find(ufA, edges[i][1]) != find(ufA, edges[i][2])) {
                unionSets(ufA, edges[i][1], edges[i][2]);
                unionSets(ufB, edges[i][1], edges[i][2]);
                usedEdges++;
            }
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        if (edges[i][0] == 1) {
            if (find(ufA, edges[i][1]) != find(ufA, edges[i][2])) {
                unionSets(ufA, edges[i][1], edges[i][2]);
                usedEdges++;
            }
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        if (edges[i][0] == 2) {
            if (find(ufB, edges[i][1]) != find(ufB, edges[i][2])) {
                unionSets(ufB, edges[i][1], edges[i][2]);
                usedEdges++;
            }
        }
    }

    if (find(ufA, 1) != find(ufA, n) || find(ufB, 1) != find(ufB, n)) {
        free(ufA);
        free(ufB);
        return -1;
    }

    free(ufA);
    free(ufB);
    return edgesSize - usedEdges;
}