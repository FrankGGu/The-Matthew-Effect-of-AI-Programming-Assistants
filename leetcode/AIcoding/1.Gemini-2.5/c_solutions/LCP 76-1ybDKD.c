#include <stdbool.h>

bool isMagicSquare(int** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0) {
        return false;
    }
    if (gridSize == 1) {
        return true;
    }

    int magicSum = 0;
    for (int j = 0; j < gridSize; j++) {
        magicSum += grid[0][j];
    }

    for (int i = 0; i < gridSize; i++) {
        int currentRowSum = 0;
        for (int j = 0; j < gridSize; j++) {
            currentRowSum += grid[i][j];
        }
        if (currentRowSum != magicSum) {
            return false;
        }
    }

    for (int j = 0; j < gridSize; j++) {
        int currentColSum = 0;
        for (int i = 0; i < gridSize; i++) {
            currentColSum += grid[i][j];
        }
        if (currentColSum != magicSum) {
            return false;
        }
    }

    int mainDiagonalSum = 0;
    for (int i = 0; i < gridSize; i++) {
        mainDiagonalSum += grid[i][i];
    }
    if (mainDiagonalSum != magicSum) {
        return false;
    }

    int antiDiagonalSum = 0;
    for (int i = 0; i < gridSize; i++) {
        antiDiagonalSum += grid[i][gridSize - 1 - i];
    }
    if (antiDiagonalSum != magicSum) {
        return false;
    }

    return true;
}