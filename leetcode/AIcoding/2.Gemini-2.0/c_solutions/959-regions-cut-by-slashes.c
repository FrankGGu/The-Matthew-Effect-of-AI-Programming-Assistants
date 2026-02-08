#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unite(int parent[], int rank[], int x, int y) {
    int xroot = find(parent, x);
    int yroot = find(parent, y);
    if (xroot == yroot)
        return;
    if (rank[xroot] < rank[yroot])
        parent[xroot] = yroot;
    else if (rank[xroot] > rank[yroot])
        parent[yroot] = xroot;
    else {
        parent[yroot] = xroot;
        rank[xroot]++;
    }
}

int regionsBySlashes(char** grid, int gridSize) {
    int n = gridSize;
    int parent[4 * n * n];
    int rank[4 * n * n];
    for (int i = 0; i < 4 * n * n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int idx = i * n + j;
            if (grid[i][j] == '/') {
                unite(parent, rank, idx * 4 + 0, idx * 4 + 1);
                unite(parent, rank, idx * 4 + 2, idx * 4 + 3);
            } else if (grid[i][j] == '\\') {
                unite(parent, rank, idx * 4 + 0, idx * 4 + 3);
                unite(parent, rank, idx * 4 + 1, idx * 4 + 2);
            } else {
                unite(parent, rank, idx * 4 + 0, idx * 4 + 1);
                unite(parent, rank, idx * 4 + 1, idx * 4 + 2);
                unite(parent, rank, idx * 4 + 2, idx * 4 + 3);
            }
            if (i > 0) {
                unite(parent, rank, idx * 4 + 0, ((i - 1) * n + j) * 4 + 2);
            }
            if (j > 0) {
                unite(parent, rank, idx * 4 + 3, (i * n + (j - 1)) * 4 + 1);
            }
        }
    }
    int count = 0;
    for (int i = 0; i < 4 * n * n; i++) {
        if (parent[i] == i)
            count++;
    }
    return count;
}