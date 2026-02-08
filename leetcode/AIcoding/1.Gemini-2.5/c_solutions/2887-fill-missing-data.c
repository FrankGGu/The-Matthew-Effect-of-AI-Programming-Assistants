int** fillMissingData(int** data, int dataSize, int* dataColSize, int k, int* returnSize, int** returnColumnSizes) {
    *returnSize = dataSize;
    *returnColumnSizes = dataColSize;

    for (int i = 0; i < dataSize; i++) {
        int m = dataColSize[i];
        int sum = 0;
        int count = 0;

        for (int j = 0; j < m; j++) {
            if (data[i][j] != -1) {
                sum += data[i][j];
                count++;
            }
        }

        int avg_val = 0;
        if (count > 0) {
            avg_val = (int)((double)sum / count);
        }

        for (int j = 0; j < m; j++) {
            if (data[i][j] == -1) {
                data[i][j] = avg_val;
            }
        }
    }

    return data;
}