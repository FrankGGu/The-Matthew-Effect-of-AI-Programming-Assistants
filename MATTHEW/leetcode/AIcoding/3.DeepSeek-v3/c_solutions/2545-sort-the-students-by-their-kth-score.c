/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** sortTheStudents(int** score, int scoreSize, int* scoreColSize, int k, int* returnSize, int** returnColumnSizes) {
    *returnSize = scoreSize;
    *returnColumnSizes = malloc(scoreSize * sizeof(int));
    for (int i = 0; i < scoreSize; i++) {
        (*returnColumnSizes)[i] = *scoreColSize;
    }

    int** result = malloc(scoreSize * sizeof(int*));
    for (int i = 0; i < scoreSize; i++) {
        result[i] = malloc((*scoreColSize) * sizeof(int));
        for (int j = 0; j < *scoreColSize; j++) {
            result[i][j] = score[i][j];
        }
    }

    for (int i = 0; i < scoreSize - 1; i++) {
        for (int j = 0; j < scoreSize - i - 1; j++) {
            if (result[j][k] < result[j + 1][k]) {
                int* temp = result[j];
                result[j] = result[j + 1];
                result[j + 1] = temp;
            }
        }
    }

    return result;
}