int** floodFill(int** image, int imageSize, int* imageColSize, int sr, int sc, int newColor, int* returnSize, int** returnColumnSizes) {
    int originalColor = image[sr][sc];
    if (originalColor == newColor) return image;
    *returnSize = imageSize;
    *returnColumnSizes = (int*)malloc(imageSize * sizeof(int));
    for (int i = 0; i < imageSize; i++) {
        (*returnColumnSizes)[i] = *imageColSize;
    }

    void dfs(int r, int c) {
        if (r < 0 || r >= imageSize || c < 0 || c >= *imageColSize || image[r][c] != originalColor) {
            return;
        }
        image[r][c] = newColor;
        dfs(r + 1, c);
        dfs(r - 1, c);
        dfs(r, c + 1);
        dfs(r, c - 1);
    }

    dfs(sr, sc);
    return image;
}