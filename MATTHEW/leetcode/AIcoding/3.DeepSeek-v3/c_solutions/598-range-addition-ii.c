int maxCount(int m, int n, int** ops, int opsSize, int* opsColSize) {
    int minRow = m;
    int minCol = n;

    for (int i = 0; i < opsSize; i++) {
        if (ops[i][0] < minRow) {
            minRow = ops[i][0];
        }
        if (ops[i][1] < minCol) {
            minCol = ops[i][1];
        }
    }

    return minRow * minCol;
}