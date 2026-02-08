#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
    bool val;
    bool isLeaf;
    struct Node *topLeft;
    struct Node *topRight;
    struct Node *bottomLeft;
    struct Node *bottomRight;
};

struct Node* construct(int** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0) return NULL;

    bool allSame = true;
    int firstVal = grid[0][0];
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridSize; j++) {
            if (grid[i][j] != firstVal) {
                allSame = false;
                break;
            }
        }
        if (!allSame) break;
    }

    struct Node* node = (struct Node*)malloc(sizeof(struct Node));
    if (allSame) {
        node->isLeaf = true;
        node->val = firstVal;
        node->topLeft = NULL;
        node->topRight = NULL;
        node->bottomLeft = NULL;
        node->bottomRight = NULL;
    } else {
        node->isLeaf = false;
        node->val = false; 
        int newSize = gridSize / 2;

        int** topLeftGrid = (int**)malloc(sizeof(int*) * newSize);
        int** topRightGrid = (int**)malloc(sizeof(int*) * newSize);
        int** bottomLeftGrid = (int**)malloc(sizeof(int*) * newSize);
        int** bottomRightGrid = (int**)malloc(sizeof(int*) * newSize);
        for (int i = 0; i < newSize; i++) {
            topLeftGrid[i] = (int*)malloc(sizeof(int) * newSize);
            topRightGrid[i] = (int*)malloc(sizeof(int) * newSize);
            bottomLeftGrid[i] = (int*)malloc(sizeof(int) * newSize);
            bottomRightGrid[i] = (int*)malloc(sizeof(int) * newSize);

            for (int j = 0; j < newSize; j++) {
                topLeftGrid[i][j] = grid[i][j];
                topRightGrid[i][j] = grid[i][j + newSize];
                bottomLeftGrid[i][j] = grid[i + newSize][j];
                bottomRightGrid[i][j] = grid[i + newSize][j + newSize];
            }
        }

        node->topLeft = construct(topLeftGrid, newSize, gridColSize);
        node->topRight = construct(topRightGrid, newSize, gridColSize);
        node->bottomLeft = construct(bottomLeftGrid, newSize, gridColSize);
        node->bottomRight = construct(bottomRightGrid, newSize, gridColSize);

        for (int i = 0; i < newSize; i++) {
            free(topLeftGrid[i]);
            free(topRightGrid[i]);
            free(bottomLeftGrid[i]);
            free(bottomRightGrid[i]);
        }
        free(topLeftGrid);
        free(topRightGrid);
        free(bottomLeftGrid);
        free(bottomRightGrid);
    }

    return node;
}