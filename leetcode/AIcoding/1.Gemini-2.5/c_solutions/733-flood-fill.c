void dfs(int** image, int imageSize, int* imageColSize, int sr, int sc, int color, int newColor) {
    if (sr < 0 || sr >= imageSize || sc < 0 || sc >= imageColSize[0] || image[sr][sc] != color || image[sr][sc] == newColor) {
        return;
    }

    image[sr][sc] = newColor;

    dfs(image, imageSize, imageColSize, sr + 1, sc, color, newColor);
    dfs(image, imageSize, imageColSize, sr - 1, sc, color, newColor);
    dfs(image, imageSize, imageColSize, sr, sc + 1, color, newColor);
    dfs(image, imageSize, imageColSize, sr, sc - 1, color, newColor);
}

int** floodFill(int** image, int imageSize, int* imageColSize, int sr, int sc, int newColor, int* returnSize, int** returnColumnSizes) {
    int originalColor = image[sr][sc];

    if (originalColor != newColor) {
        dfs(image, imageSize, imageColSize, sr, sc, originalColor, newColor);
    }

    *returnSize = imageSize;
    *returnColumnSizes = (int*)malloc(sizeof(int) * imageSize);
    for (int i = 0; i < imageSize; i++) {
        (*returnColumnSizes)[i] = imageColSize[0];
    }

    return image;
}