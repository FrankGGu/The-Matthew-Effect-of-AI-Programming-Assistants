#include <stdlib.h>

int* findPeakRecursive(int** mat, int matSize, int numCols, int leftCol, int rightCol) {
    if (leftCol > rightCol) {
        return NULL; 
    }

    int midCol = leftCol + (rightCol - leftCol) / 2;

    int maxValInMidCol = -1;
    int maxRow = -1;
    for (int r = 0; r < matSize; r++) {
        if (mat[r][midCol] > maxValInMidCol) {
            maxValInMidCol = mat[r][midCol];
            maxRow = r;
        }
    }

    int leftNeighborVal = -1;
    if (midCol > 0) {
        leftNeighborVal = mat[maxRow][midCol - 1];
    }

    int rightNeighborVal = -1;
    if (midCol < numCols - 1) {
        rightNeighborVal = mat[maxRow][midCol + 1];
    }

    if (maxValInMidCol > leftNeighborVal && maxValInMidCol > rightNeighborVal) {
        int* result = (int*)malloc(sizeof(int) * 2);
        result[0] = maxRow;
        result[1] = midCol;
        return result;
    } else if (leftNeighborVal > maxValInMidCol) {
        return findPeakRecursive(mat, matSize, numCols, leftCol, midCol - 1);
    } else {
        return findPeakRecursive(mat, matSize, numCols, midCol + 1, rightCol);
    }
}

int* findPeakElement(int** mat, int matSize, int* matColSize, int* returnSize) {
    *returnSize = 2;
    if (matSize == 0 || matColSize[0] == 0) {
        return NULL;
    }

    int numCols = matColSize[0];

    return findPeakRecursive(mat, matSize, numCols, 0, numCols - 1);
}