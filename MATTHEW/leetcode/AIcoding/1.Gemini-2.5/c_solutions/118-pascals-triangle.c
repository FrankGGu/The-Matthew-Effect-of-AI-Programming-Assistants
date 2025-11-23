#include <stdlib.h>

int** generate(int numRows, int* returnSize, int** returnColumnSizes) {
    if (numRows == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int** triangle = (int**)malloc(numRows * sizeof(int*));
    *returnColumnSizes = (int*)malloc(numRows * sizeof(int));
    *returnSize = numRows;

    for (int i = 0; i < numRows; i++) {
        int currentRowSize = i + 1;
        triangle[i] = (int*)malloc(currentRowSize * sizeof(int));
        (*returnColumnSizes)[i] = currentRowSize;

        triangle[i][0] = 1; // First element is always 1
        if (i > 0) {
            triangle[i][currentRowSize - 1] = 1; // Last element is always 1 (for rows > 0)
        }

        for (int j = 1; j < currentRowSize - 1; j++) {
            triangle[i][j] = triangle[i - 1][j - 1] + triangle[i - 1][j];
        }
    }

    return triangle;
}