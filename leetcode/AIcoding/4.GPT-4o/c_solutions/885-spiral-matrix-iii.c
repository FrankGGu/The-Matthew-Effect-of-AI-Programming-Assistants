int** spiralMatrixIII(int rows, int cols, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(rows * cols * sizeof(int*));
    for (int i = 0; i < rows * cols; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
    }
    int dr[] = {0, 1, 0, -1};
    int dc[] = {1, 0, -1, 0};
    int r = 0, c = 0, d = 0, count = 0, total = rows * cols;
    while (count < total) {
        if (r >= 0 && r < rows && c >= 0 && c < cols) {
            result[count][0] = r;
            result[count][1] = c;
            count++;
        }
        r += dr[d];
        c += dc[d];
        if (r >= rows || r < 0 || c >= cols || c < 0 || result[count - 1][0] == r && result[count - 1][1] == c) {
            r -= dr[d];
            c -= dc[d];
            d = (d + 1) % 4;
            r += dr[d];
            c += dc[d];
        }
    }
    *returnSize = total;
    *returnColumnSizes = (int*)malloc(total * sizeof(int));
    for (int i = 0; i < total; i++) {
        (*returnColumnSizes)[i] = 2;
    }
    return result;
}