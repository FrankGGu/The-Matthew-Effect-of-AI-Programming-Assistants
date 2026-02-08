/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** floodFill(int** image, int imageSize, int* imageColSize, int sr, int sc, int color, int* returnSize, int** returnColumnSizes) {
    int originalColor = image[sr][sc];
    if (originalColor == color) {
        *returnSize = imageSize;
        *returnColumnSizes = malloc(imageSize * sizeof(int));
        for (int i = 0; i < imageSize; i++) {
            (*returnColumnSizes)[i] = imageColSize[i];
        }
        int** result = malloc(imageSize * sizeof(int*));
        for (int i = 0; i < imageSize; i++) {
            result[i] = malloc(imageColSize[i] * sizeof(int));
            for (int j = 0; j < imageColSize[i]; j++) {
                result[i][j] = image[i][j];
            }
        }
        return result;
    }

    int rows = imageSize;
    int cols = imageColSize[0];

    *returnSize = imageSize;
    *returnColumnSizes = malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    int** result = malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            result[i][j] = image[i][j];
        }
    }

    void dfs(int r, int c) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || result[r][c] != originalColor) {
            return;
        }
        result[r][c] = color;
        dfs(r - 1, c);
        dfs(r + 1, c);
        dfs(r, c - 1);
        dfs(r, c + 1);
    }

    dfs(sr, sc);
    return result;
}