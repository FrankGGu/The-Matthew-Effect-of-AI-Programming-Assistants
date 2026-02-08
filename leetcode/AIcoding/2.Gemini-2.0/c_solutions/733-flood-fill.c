#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** floodFill(int** image, int imageSize, int* imageColSize, int sr, int sc, int newColor, int* returnSize, int** returnColumnSizes) {
    int originalColor = image[sr][sc];
    if (originalColor == newColor) {
        *returnSize = imageSize;
        *returnColumnSizes = (int*)malloc(imageSize * sizeof(int));
        for (int i = 0; i < imageSize; i++) {
            (*returnColumnSizes)[i] = imageColSize[i];
        }
        return image;
    }

    int rows = imageSize;
    int cols = imageColSize[0];

    void dfs(int r, int c) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || image[r][c] != originalColor) {
            return;
        }

        image[r][c] = newColor;

        dfs(r + 1, c);
        dfs(r - 1, c);
        dfs(r, c + 1);
        dfs(r, c - 1);
    }

    dfs(sr, sc);

    *returnSize = imageSize;
    *returnColumnSizes = (int*)malloc(imageSize * sizeof(int));
    for (int i = 0; i < imageSize; i++) {
        (*returnColumnSizes)[i] = imageColSize[i];
    }

    return image;
}