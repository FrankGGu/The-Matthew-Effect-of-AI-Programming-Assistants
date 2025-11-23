#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Edge;

int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void union_sets(int* parent, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        parent[rootY] = rootX;
    }
}

Edge* findRedundantDirectedConnection(int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int* parent = (int*)malloc((edgesSize + 1) * sizeof(int));
    for (int i = 0; i <= edgesSize; i++) {
        parent[i] = i;
    }

    Edge* redundant1 = NULL;
    Edge* redundant2 = NULL;

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        if (parent[v] != v) {
            redundant1 = (Edge*)malloc(sizeof(Edge));
            redundant1->x = u;
            redundant1->y = v;
            continue;
        }
        union_sets(parent, u, v);
    }

    for (int i = 0; i <= edgesSize; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        if (parent[v] != v) {
            redundant2 = (Edge*)malloc(sizeof(Edge));
            redundant2->x = u;
            redundant2->y = v;
            continue;
        }
        union_sets(parent, u, v);
    }

    if (redundant1 == NULL) {
        return (Edge*)redundant2;
    }
    return (Edge*)redundant1;
}

int main() {
    // This main function is for testing purposes and should not be included in the final submission.
    return 0;
}