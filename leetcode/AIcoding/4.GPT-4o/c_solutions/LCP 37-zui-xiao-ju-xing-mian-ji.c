int minArea(char** image, int imageSize, int* imageColSize) {
    int left = imageColSize[0], right = 0, top = imageSize, bottom = 0;

    for (int i = 0; i < imageSize; i++) {
        for (int j = 0; j < imageColSize[0]; j++) {
            if (image[i][j] == '1') {
                if (j < left) left = j;
                if (j > right) right = j;
                if (i < top) top = i;
                if (i > bottom) bottom = i;
            }
        }
    }

    if (left == right || top == bottom) return 0;

    return (right - left + 1) * (bottom - top + 1);
}