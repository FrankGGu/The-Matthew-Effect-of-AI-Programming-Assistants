#include <stdlib.h> // For malloc and free

int* parent;
int* ranks;

int find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent[i]);
}

void unite(int i, int j) {
    int rootI = find(i);
    int rootJ = find(j);

    if (rootI != rootJ) {
        if (ranks[rootI] < ranks[rootJ]) {
            parent[rootI] = rootJ;
        } else if (ranks[rootI] > ranks[rootJ]) {
            parent[rootJ] = rootI;
        } else {
            parent[rootJ] = rootI;
            ranks[rootI]++;
        }
    }
}

int makeConnected(int n, int** connections, int connectionsSize, int* connectionsColSize) {
    if (connectionsSize < n - 1) {
        return -1;
    }

    parent = (int*)malloc(n * sizeof(int));
    ranks = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        parent[i] = i;
        ranks[i] = 0;
    }

    int redundant_cables = 0;
    for (int i = 0; i < connectionsSize; ++i) {
        int u = connections[i][0];
        int v = connections[i][1];

        int rootU = find(u);
        int rootV = find(v);

        if (rootU != rootV) {
            unite(u, v);
        } else {
            redundant_cables++;
        }
    }

    int num_components = 0;
    for (int i = 0; i < n; ++i) {
        if (parent[i] == i) {
            num_components++;
        }
    }

    int operations_needed = num_components - 1;

    free(parent);
    free(ranks);

    if (redundant_cables >= operations_needed) {
        return operations_needed;
    } else {
        return -1;
    }
}