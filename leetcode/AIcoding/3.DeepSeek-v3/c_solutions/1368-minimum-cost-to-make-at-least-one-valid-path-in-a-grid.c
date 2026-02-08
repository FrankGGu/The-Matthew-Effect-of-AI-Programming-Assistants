int minCost(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int dirs[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    int** cost = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        cost[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            cost[i][j] = INT_MAX;
        }
    }

    int deque[m * n][2];
    int front = 0, rear = 0;

    cost[0][0] = 0;
    deque[rear][0] = 0;
    deque[rear][1] = 0;
    rear++;

    while (front != rear) {
        int x = deque[front][0];
        int y = deque[front][1];
        front++;

        for (int k = 0; k < 4; k++) {
            int nx = x + dirs[k][0];
            int ny = y + dirs[k][1];
            int newCost = cost[x][y] + (grid[x][y] == k + 1 ? 0 : 1);

            if (nx >= 0 && nx < m && ny >= 0 && ny < n && newCost < cost[nx][ny]) {
                cost[nx][ny] = newCost;
                if (grid[x][y] == k + 1) {
                    front--;
                    deque[front][0] = nx;
                    deque[front][1] = ny;
                } else {
                    deque[rear][0] = nx;
                    deque[rear][1] = ny;
                    rear++;
                }
            }
        }
    }

    int result = cost[m-1][n-1];

    for (int i = 0; i < m; i++) {
        free(cost[i]);
    }
    free(cost);

    return result;
}