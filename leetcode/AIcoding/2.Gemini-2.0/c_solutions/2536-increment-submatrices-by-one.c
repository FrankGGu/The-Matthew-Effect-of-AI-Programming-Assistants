#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** rangeAddQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    for (int i = 0; i < n; i++) {
        result[i] = (int*)calloc(n, sizeof(int));
        (*returnColumnSizes)[i] = n;
    }

    for (int i = 0; i < queriesSize; i++) {
        int row1 = queries[i][0];
        int col1 = queries[i][1];
        int row2 = queries[i][2];
        int col2 = queries[i][3];

        for (int row = row1; row <= row2; row++) {
            for (int col = col1; col <= col2; col++) {
                result[row][col]++;
            }
        }
    }

    return result;
}