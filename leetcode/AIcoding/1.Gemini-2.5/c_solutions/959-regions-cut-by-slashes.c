#include <stdlib.h>
#include <stdbool.h>

int* parent;
int* ranks;
int numRegions;

int find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent[i]);
}

bool unite(int i, int j) {
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
        numRegions--; // A successful merge reduces the number of regions
        return true;
    }
    return false;
}

int getNodeIdx(int r, int c, int part, int N) {
    return (r * N + c) * 4 + part;
}

int regionsBySlashes(char ** grid, int gridSize) {
    int N = gridSize;
    int totalNodes = N * N * 4;

    // Allocate memory for DSU arrays
    parent = (int*)malloc(sizeof(int) * totalNodes);
    ranks = (int*)malloc(sizeof(int) * totalNodes);

    // Initialize DSU: each node is its own parent, rank is 0
    // Initially, each small triangle is considered a separate region
    numRegions = totalNodes; 
    for (int i = 0; i < totalNodes; ++i) {
        parent[i] = i;
        ranks[i] = 0;
    }

    // Iterate through the grid cells
    for (int r = 0; r < N; ++r) {
        for (int c = 0; c < N; ++c) {
            // Get indices for the 4 parts of the current cell (r, c)
            int top = getNodeIdx(r, c, 0, N);
            int right = getNodeIdx(r, c, 1, N);
            int bottom = getNodeIdx(r, c, 2, N);
            int left = getNodeIdx(r, c, 3, N);

            char cellChar = grid[r][c];

            // 1. Internal connections within the current cell based on its character
            if (cellChar == '/') {
                // '/' connects top-left and bottom-right
                unite(top, left);
                unite(right, bottom);
            } else if (cellChar == '\\') {
                // '\' connects top-right and bottom-left
                unite(top, right);
                unite(left, bottom);
            } else { // cellChar == ' '
                // ' ' connects all four triangles
                unite(top, right);
                unite(right, bottom);
                unite(bottom, left);
            }

            // 2. External connections with adjacent cells
            // Connect top part of current cell to bottom part of cell above
            if (r > 0) {
                int top_current_cell = top; // (r, c, 0)
                int bottom_above_cell = getNodeIdx(r - 1, c, 2, N); // (r-1, c, 2)
                unite(top_current_cell, bottom_above_cell);
            }

            // Connect right part of current cell to left part of cell to its right
            if (c < N - 1) {
                int right_current_cell = right; // (r, c, 1)
                int left_next_cell = getNodeIdx(r, c + 1, 3, N); // (r, c+1, 3)
                unite(right_current_cell, left_next_cell);
            }
        }
    }

    // Free allocated memory
    free(parent);
    free(ranks);

    return numRegions;
}