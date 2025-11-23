#include <stdio.h>
#include <stdlib.h>

int** generate(int numRows, int** returnSize, int** returnColumnSizes) {
    *returnSize = (int*)malloc(numRows * sizeof(int));
    *returnColumnSizes = (int*)malloc(numRows * sizeof(int));

    int** triangle = (int**)malloc(numRows * sizeof(int*));

    for (int i = 0; i < numRows; i++) {
        triangle[i] = (int*)malloc((i + 1) * sizeof(int));
        (*returnSize)[i] = i + 1;
        (*returnColumnSizes)[i] = i + 1;

        triangle[i][0] = 1;
        triangle[i][i] = 1;

        for (int j = 1; j < i; j++) {
            triangle[i][j] = triangle[i - 1][j - 1] + triangle[i - 1][j];
        }
    }

    return triangle;
}