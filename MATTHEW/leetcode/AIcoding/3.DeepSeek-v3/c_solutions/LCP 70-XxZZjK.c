int* findSandArea(char** land, int landSize, int* landColSize, int* returnSize) {
    int rows = landSize;
    int cols = landColSize[0];
    int* result = malloc(2 * sizeof(int));
    *returnSize = 2;
    result[0] = -1;
    result[1] = -1;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (land[i][j] == '0') {
                int count = 0;
                if (i > 0 && land[i-1][j] == '0') count++;
                if (i < rows-1 && land[i+1][j] == '0') count++;
                if (j > 0 && land[i][j-1] == '0') count++;
                if (j < cols-1 && land[i][j+1] == '0') count++;

                if (count == 1) {
                    result[0] = i;
                    result[1] = j;
                    return result;
                }
            }
        }
    }

    return result;
}