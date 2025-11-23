/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** reconstructMatrix(int upper, int lower, int* colsum, int colsumSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(2 * sizeof(int*));
    *returnColumnSizes = (int*)malloc(2 * sizeof(int));
    (*returnColumnSizes)[0] = colsumSize;
    (*returnColumnSizes)[1] = colsumSize;
    result[0] = (int*)calloc(colsumSize, sizeof(int));
    result[1] = (int*)calloc(colsumSize, sizeof(int));
    *returnSize = 2;

    for (int i = 0; i < colsumSize; i++) {
        if (colsum[i] == 2) {
            result[0][i] = 1;
            result[1][i] = 1;
            upper--;
            lower--;
        } else if (colsum[i] == 1) {
            if (upper >= lower) {
                result[0][i] = 1;
                upper--;
            } else {
                result[1][i] = 1;
                lower--;
            }
        }
    }

    if (upper != 0 || lower != 0) {
        *returnSize = 0;
        free(result[0]);
        free(result[1]);
        free(result);
        free(*returnColumnSizes);
        return NULL;
    }

    return result;
}