#include <stdio.h>
#include <stdlib.h>

int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSet(int* parent, int* rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootX] = rootY;
            if (rank[rootX] == rank[rootY]) {
                rank[rootY]++;
            }
        }
    }
}

int findCircleNum(int** isConnected, int isConnectedSize, int* isConnectedColSize) {
    int n = isConnectedSize;
    int* parent = (int*)malloc(n * sizeof(int));
    int* rank = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (isConnected[i][j] == 1 && i != j) {
                unionSet(parent, rank, i, j);
            }
        }
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (find(parent, i) == i) {
            count++;
        }
    }

    free(parent);
    free(rank);
    return count;
}