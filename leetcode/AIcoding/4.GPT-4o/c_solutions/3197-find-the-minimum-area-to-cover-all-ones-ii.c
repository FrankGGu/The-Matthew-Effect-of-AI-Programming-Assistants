int minArea(char** image, int imageSize, int* imageColSize, char** query, int querySize, int* queryColSize) {
    int minX = imageSize, minY = *imageColSize, maxX = 0, maxY = 0;

    for (int i = 0; i < imageSize; i++) {
        for (int j = 0; j < *imageColSize; j++) {
            if (image[i][j] == '1') {
                if (i < minX) minX = i;
                if (i > maxX) maxX = i;
                if (j < minY) minY = j;
                if (j > maxY) maxY = j;
            }
        }
    }

    return (maxX - minX + 1) * (maxY - minY + 1);
}