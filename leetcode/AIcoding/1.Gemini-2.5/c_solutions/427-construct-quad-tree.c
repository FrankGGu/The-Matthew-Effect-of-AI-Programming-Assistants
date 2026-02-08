#include <stdlib.h>
#include <stdbool.h>

bool isAllSame(int** grid, int rowStart, int colStart, int size) {
    int firstVal = grid[rowStart][colStart];
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            if (grid[rowStart + i][colStart + j] != firstVal) {
                return false;
            }
        }
    }
    return true;
}

struct Node* constructHelper(int** grid, int rowStart, int colStart, int size) {
    struct Node* node = (struct Node*)malloc(sizeof(struct Node));

    if (isAllSame(grid, rowStart, colStart, size)) {
        node->val = (grid[rowStart][colStart] == 1);
        node->isLeaf = true;
        node->topLeft = NULL;
        node->topRight = NULL;
        node->bottomLeft = NULL;
        node->bottomRight = NULL;
    } else {
        node->val = true; 
        node->isLeaf = false;
        int halfSize = size / 2;
        node->topLeft = constructHelper(grid, rowStart, colStart, halfSize);
        node->topRight = constructHelper(grid, rowStart, colStart + halfSize, halfSize);
        node->bottomLeft = constructHelper(grid, rowStart + halfSize, colStart, halfSize);
        node->bottomRight = constructHelper(grid, rowStart + halfSize, colStart + halfSize, halfSize);
    }

    return node;
}

struct Node* construct(int** grid, int gridSize, int* gridColSize) {
    if (grid == NULL || gridSize == 0) {
        return NULL;
    }
    return constructHelper(grid, 0, 0, gridSize);
}