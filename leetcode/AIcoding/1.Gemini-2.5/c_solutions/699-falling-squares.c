#include <stdlib.h>

typedef struct {
    int left;
    int right;
    int height;
} FallenSquare;

static inline int int_max(int a, int b) {
    return a > b ? a : b;
}

int* fallingSquares(int** positions, int positionsSize, int* positionsColSize, int* returnSize) {
    *returnSize = positionsSize;
    int* result = (int*)malloc(sizeof(int) * positionsSize);

    FallenSquare* fallenSquares = (FallenSquare*)malloc(sizeof(FallenSquare) * positionsSize);
    int fallenCount = 0;

    int maxOverallHeight = 0;

    for (int i = 0; i < positionsSize; ++i) {
        int currentLeft = positions[i][0];
        int currentSideLength = positions[i][1];
        int currentRight = currentLeft + currentSideLength - 1;

        int baseHeight = 0;

        for (int j = 0; j < fallenCount; ++j) {
            int prevLeft = fallenSquares[j].left;
            int prevRight = fallenSquares[j].right;
            int prevHeight = fallenSquares[j].height;

            if (currentLeft <= prevRight && currentRight >= prevLeft) {
                baseHeight = int_max(baseHeight, prevHeight);
            }
        }

        int currentSquareTotalHeight = baseHeight + currentSideLength;

        fallenSquares[fallenCount].left = currentLeft;
        fallenSquares[fallenCount].right = currentRight;
        fallenSquares[fallenCount].height = currentSquareTotalHeight;
        fallenCount++;

        maxOverallHeight = int_max(maxOverallHeight, currentSquareTotalHeight);

        result[i] = maxOverallHeight;
    }

    free(fallenSquares);
    return result;
}