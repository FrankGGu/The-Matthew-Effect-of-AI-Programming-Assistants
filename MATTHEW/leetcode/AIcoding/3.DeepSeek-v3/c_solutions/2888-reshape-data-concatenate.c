#include <stdlib.h>

// Helper function to calculate total rows after concatenation
int calculateTotalRows(int dfsSize, int* dfsColSizes, int numDataFrames) {
    int totalRows = 0;
    for (int i = 0; i < numDataFrames; i++) {
        totalRows += dfsColSizes[i];
    }
    return totalRows;
}

// Helper function to calculate total columns (assuming all have same number of columns)
int calculateTotalColumns(int** dfs, int dfsSize, int* dfsColSizes) {
    if (dfsSize == 0 || dfsColSizes[0] == 0) return 0;
    return dfsColSizes[0]; // All dataframes have same number of columns
}

// Helper function to copy a row from source to destination
void copyRow(int* dest, int* src, int numCols) {
    for (int j = 0; j < numCols; j++) {
        dest[j] = src[j];
    }
}

/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** concatArrays(int** dfs, int dfsSize, int* dfsColSizes, int* returnSize, int** returnColumnSizes) {
    if (dfsSize == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    // Calculate dimensions of result
    int totalRows = calculateTotalRows(dfsSize, dfsColSizes, dfsSize);
    int totalCols = calculateTotalColumns(dfs, dfsSize, dfsColSizes);

    // Allocate memory for result
    int** result = (int**)malloc(totalRows * sizeof(int*));
    *returnColumnSizes = (int*)malloc(totalRows * sizeof(int));
    *returnSize = totalRows;

    // Fill the result array
    int resultRow = 0;
    for (int i = 0; i < dfsSize; i++) {
        for (int j = 0; j < dfsColSizes[i]; j++) {
            result[resultRow] = (int*)malloc(totalCols * sizeof(int));
            (*returnColumnSizes)[resultRow] = totalCols;
            copyRow(result[resultRow], dfs[i] + j * totalCols, totalCols);
            resultRow++;
        }
    }

    return result;
}