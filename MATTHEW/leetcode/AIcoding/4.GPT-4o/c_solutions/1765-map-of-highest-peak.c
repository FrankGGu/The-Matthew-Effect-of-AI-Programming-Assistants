int** highestPeak(int** isWater, int isWaterSize, int* isWaterColSize, int* returnSize, int** returnColumnSizes) {
    int rows = isWaterSize, cols = isWaterColSize[0];
    int** result = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
    }

    int** directions = (int**)malloc(4 * sizeof(int*));
    for (int i = 0; i < 4; i++) {
        directions[i] = (int*)malloc(2 * sizeof(int));
    }
    directions[0][0] = 0; directions[0][1] = 1;
    directions[1][0] = 1; directions[1][1] = 0;
    directions[2][0] = 0; directions[2][1] = -1;
    directions[3][0] = -1; directions[3][1] = 0;

    int queue[rows * cols][2];
    int front = 0, rear = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (isWater[i][j] == 1) {
                result[i][j] = 0;
                queue[rear][0] = i;
                queue[rear][1] = j;
                rear++;
            } else {
                result[i][j] = -1;
            }
        }
    }

    while (front < rear) {
        int x = queue[front][0], y = queue[front][1];
        front++;

        for (int i = 0; i < 4; i++) {
            int nx = x + directions[i][0], ny = y + directions[i][1];
            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && result[nx][ny] == -1) {
                result[nx][ny] = result[x][y] + 1;
                queue[rear][0] = nx;
                queue[rear][1] = ny;
                rear++;
            }
        }
    }

    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    for (int i = 0; i < 4; i++) {
        free(directions[i]);
    }
    free(directions);

    return result;
}