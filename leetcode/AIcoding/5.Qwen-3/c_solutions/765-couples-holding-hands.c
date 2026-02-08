#include <stdio.h>
#include <stdlib.h>

int find(int *parent, int x) {
    if (parent[x] != x)
        parent[x] = find(parent, parent[x]);
    return parent[x];
}

void unionSet(int *parent, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY)
        parent[rootY] = rootX;
}

int minSwapsCouples(int *row, int rowSize) {
    int *parent = (int *)malloc(rowSize * sizeof(int));
    for (int i = 0; i < rowSize; i++)
        parent[i] = i;

    for (int i = 0; i < rowSize; i += 2) {
        int a = row[i];
        int b = row[i + 1];
        unionSet(parent, a / 2, b / 2);
    }

    int *rank = (int *)malloc(rowSize / 2 * sizeof(int));
    for (int i = 0; i < rowSize / 2; i++)
        rank[i] = 1;

    int swaps = 0;
    for (int i = 0; i < rowSize; i += 2) {
        int root = find(parent, i / 2);
        if (rank[root] > 1) {
            swaps++;
            rank[root]--;
        }
    }

    free(parent);
    free(rank);
    return swaps;
}