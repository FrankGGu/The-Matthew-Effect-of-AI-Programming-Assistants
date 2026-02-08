/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
char** rotateTheBox(char** box, int boxSize, int* boxColSize, int* returnSize, int** returnColumnSizes) {
    int m = boxSize;
    int n = boxColSize[0];

    *returnSize = n;
    *returnColumnSizes = malloc(n * sizeof(int));
    char** result = malloc(n * sizeof(char*));
    for (int i = 0; i < n; i++) {
        result[i] = malloc(m * sizeof(char));
        (*returnColumnSizes)[i] = m;
    }

    for (int i = 0; i < m; i++) {
        int bottom = n - 1;
        for (int j = n - 1; j >= 0; j--) {
            if (box[i][j] == '*') {
                bottom = j - 1;
            } else if (box[i][j] == '#') {
                box[i][j] = '.';
                box[i][bottom] = '#';
                bottom--;
            }
        }
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            result[j][m - 1 - i] = box[i][j];
        }
    }

    return result;
}