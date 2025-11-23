#include <stdio.h>
#include <stdlib.h>

int makeConnected(int n, int* connections, int connectionsSize) {
    if (connectionsSize < n - 1) return -1;

    int* parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unionSet(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            parent[rootY] = rootX;
        }
    }

    for (int i = 0; i < connectionsSize; i++) {
        unionSet(connections[i][0], connections[i][1]);
    }

    int uniqueRoots = 0;
    for (int i = 0; i < n; i++) {
        if (find(i) == i) {
            uniqueRoots++;
        }
    }

    free(parent);
    return uniqueRoots - 1;
}