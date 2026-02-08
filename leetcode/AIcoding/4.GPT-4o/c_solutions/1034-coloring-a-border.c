int isBorder(int** image, int imageSize, int* imageColSize, int r, int c, int color, int origColor) {
    if (r < 0 || r >= imageSize || c < 0 || c >= *imageColSize || image[r][c] != origColor) {
        return 0;
    }
    int count = 0;
    if (r == 0 || r == imageSize - 1 || c == 0 || c == *imageColSize - 1) {
        count = 1;
    } else {
        count = 0;
    }
    image[r][c] = -1; // mark as visited
    count += isBorder(image, imageSize, imageColSize, r + 1, c, color, origColor);
    count += isBorder(image, imageSize, imageColSize, r - 1, c, color, origColor);
    count += isBorder(image, imageSize, imageColSize, r, c + 1, color, origColor);
    count += isBorder(image, imageSize, imageColSize, r, c - 1, color, origColor);
    if (count > 0) {
        return 1;
    }
    return 0;
}

void colorBorder(int** image, int imageSize, int* imageColSize, int r0, int c0, int color) {
    int origColor = image[r0][c0];
    int** visited = (int**)malloc(imageSize * sizeof(int*));
    for (int i = 0; i < imageSize; i++) {
        visited[i] = (int*)malloc(*imageColSize * sizeof(int));
        memset(visited[i], 0, *imageColSize * sizeof(int));
    }
    if (isBorder(image, imageSize, imageColSize, r0, c0, color, origColor)) {
        for (int i = 0; i < imageSize; i++) {
            for (int j = 0; j < *imageColSize; j++) {
                if (image[i][j] == -1) {
                    image[i][j] = color;
                }
            }
        }
    }
    for (int i = 0; i < imageSize; i++) {
        free(visited[i]);
    }
    free(visited);
}