#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unite(int parent[], int rank[], int x, int y) {
    x = find(parent, x);
    y = find(parent, y);
    if (x != y) {
        if (rank[x] < rank[y])
            parent[x] = y;
        else if (rank[x] > rank[y])
            parent[y] = x;
        else {
            parent[y] = x;
            rank[x]++;
        }
    }
}

int removeStones(int** stones, int stonesSize, int* stonesColSize) {
    int n = stonesSize;
    int parent[n];
    int rank[n];

    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (stones[i][0] == stones[j][0] || stones[i][1] == stones[j][1]) {
                unite(parent, rank, i, j);
            }
        }
    }

    int components = 0;
    for (int i = 0; i < n; i++) {
        if (parent[i] == i)
            components++;
    }

    return n - components;
}