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

    int front = 0, rear = 0;
    int* queue = (int*)malloc(rows * cols * 2 * sizeof(int));

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (mat[i][j] == 0) {
                queue[rear++] = i;
                queue[rear++] = j;
            }
        }
    }

    while (front < rear) {
        int x = queue[front++];
        int y = queue[front++];

        for (int d = 0; d < 4; d++) {
            int nx = x + directions[d][0];
            int ny = y + directions[d][1];
            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && dist[nx][ny] > dist[x][y] + 1) {
                dist[nx][ny] = dist[x][y] + 1;
                queue[rear++] = nx;
                queue[rear++] = ny;
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