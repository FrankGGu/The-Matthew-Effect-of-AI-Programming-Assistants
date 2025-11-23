int** imageSmoother(int** img, int imgSize, int* imgColSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(imgSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(imgSize * sizeof(int));
    *returnSize = imgSize;

    for (int i = 0; i < imgSize; i++) {
        result[i] = (int*)malloc(*imgColSize * sizeof(int));
        (*returnColumnSizes)[i] = *imgColSize;

        for (int j = 0; j < *imgColSize; j++) {
            int sum = 0, count = 0;
            for (int di = -1; di <= 1; di++) {
                for (int dj = -1; dj <= 1; dj++) {
                    int ni = i + di, nj = j + dj;
                    if (ni >= 0 && ni < imgSize && nj >= 0 && nj < *imgColSize) {
                        sum += img[ni][nj];
                        count++;
                    }
                }
            }
            result[i][j] = sum / count;
        }
    }

    return result;
}