int maxCount(int m, int n, int** ops, int opsSize, int* opsColSize) {
    int row = m, col = n;
    for (int i = 0; i < opsSize; i++) {
        row = row < ops[i][0] ? row : ops[i][0];
        col = col < ops[i][1] ? col : ops[i][1];
    }
    return row * col;
}