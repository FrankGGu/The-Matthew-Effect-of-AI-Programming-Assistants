int** updateMatrix(int** mat, int matSize, int* matColSize, int* returnSize, int** returnColumnSizes) {
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int rows = matSize, cols = *matColSize;
    int** dist = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dist[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dist[i][j] = (mat[i][j] == 0) ? 0 : INT_MAX;
        }
    }

    int front = 0, back = 0;
    int size = rows * cols;
    int* queue = (int*)malloc(size * sizeof(int));

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (mat[i][j] == 0) {
                queue[back++] = i * cols + j;
            }
        }
    }

    while (front < back) {
        int pos = queue[front++];
        int x = pos / cols, y = pos % cols;

        for (int d = 0; d < 4; d++) {
            int newX = x + directions[d][0];
            int newY = y + directions[d][1];
            if (newX >= 0 && newX < rows && newY >= 0 && newY < cols && dist[newX][newY] > dist[x][y] + 1) {
                dist[newX][newY] = dist[x][y] + 1;
                queue[back++] = newX * cols + newY;
            }
        }
    }

    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }
    return dist;
}