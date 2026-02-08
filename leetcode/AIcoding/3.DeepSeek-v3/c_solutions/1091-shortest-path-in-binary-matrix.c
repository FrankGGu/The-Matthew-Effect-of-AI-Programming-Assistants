int shortestPathBinaryMatrix(int** grid, int gridSize, int* gridColSize) {
    if (grid[0][0] == 1 || grid[gridSize-1][gridColSize[0]-1] == 1) {
        return -1;
    }

    int n = gridSize;
    int directions[8][2] = {{-1,-1}, {-1,0}, {-1,1}, {0,-1}, {0,1}, {1,-1}, {1,0}, {1,1}};

    int** queue = malloc(n * n * sizeof(int*));
    for (int i = 0; i < n * n; i++) {
        queue[i] = malloc(2 * sizeof(int));
    }

    int front = 0, rear = 0;
    queue[rear][0] = 0;
    queue[rear][1] = 0;
    rear++;
    grid[0][0] = 1;

    while (front < rear) {
        int x = queue[front][0];
        int y = queue[front][1];
        front++;

        if (x == n-1 && y == n-1) {
            return grid[x][y];
        }

        for (int i = 0; i < 8; i++) {
            int nx = x + directions[i][0];
            int ny = y + directions[i][1];

            if (nx >= 0 && nx < n && ny >= 0 && ny < n && grid[nx][ny] == 0) {
                queue[rear][0] = nx;
                queue[rear][1] = ny;
                rear++;
                grid[nx][ny] = grid[x][y] + 1;
            }
        }
    }

    for (int i = 0; i < n * n; i++) {
        free(queue[i]);
    }
    free(queue);

    return -1;
}