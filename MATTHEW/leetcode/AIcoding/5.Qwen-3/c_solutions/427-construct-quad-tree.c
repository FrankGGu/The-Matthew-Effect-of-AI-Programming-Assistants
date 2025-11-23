#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    bool val;
    bool isLeaf;
    struct Node* topLeft;
    struct Node* topRight;
    struct Node* bottomLeft;
    struct Node* bottomRight;
} Node;

Node* construct(int** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || *gridColSize == 0) return NULL;

    Node* root = (Node*)malloc(sizeof(Node));
    root->isLeaf = true;
    root->val = grid[0][0];

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            if (grid[i][j] != root->val) {
                root->isLeaf = false;
                break;
            }
        }
        if (!root->isLeaf) break;
    }

    if (root->isLeaf) {
        root->topLeft = NULL;
        root->topRight = NULL;
        root->bottomLeft = NULL;
        root->bottomRight = NULL;
        return root;
    }

    int mid = gridSize / 2;
    root->topLeft = construct(grid, mid, gridColSize);
    root->topRight = construct(&grid[0][mid], mid, gridColSize);
    root->bottomLeft = construct(&grid[mid][0], mid, gridColSize);
    root->bottomRight = construct(&grid[mid][mid], mid, gridColSize);

    return root;
}