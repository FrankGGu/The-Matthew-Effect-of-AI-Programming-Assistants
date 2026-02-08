int hasValidPath(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    if (m == 1 && n == 1) return 1;

    int dirs[7][4] = {
        {0, 0, 0, 0},
        {0, 1, 0, 1},
        {1, 0, 1, 0},
        {0, 0, 1, 1},
        {0, 1, 1, 0},
        {1, 0, 0, 1},
        {1, 1, 0, 0}
    };

    int dx[4] = {0, 1, 0, -1};
    int dy[4] = {1, 0, -1, 0};

    int visited[m][n];
    memset(visited, 0, sizeof(visited));

    int queue[m * n][2];
    int front = 0, rear = 0;

    queue[rear][0] = 0;
    queue[rear][1] = 0;
    rear++;
    visited[0][0] = 1;

    while (front < rear) {
        int x = queue[front][0];
        int y = queue[front][1];
        front++;

        if (x == m - 1 && y == n - 1) return 1;

        int street = grid[x][y];
        for (int d = 0; d < 4; d++) {
            if (dirs[street][d] == 0) continue;

            int nx = x + dx[d];
            int ny = y + dy[d];

            if (nx < 0 || nx >= m || ny < 0 || ny >= n || visited[nx][ny]) continue;

            int nstreet = grid[nx][ny];
            int nd = (d + 2) % 4;

            if (dirs[nstreet][nd] == 1) {
                visited[nx][ny] = 1;
                queue[rear][0] = nx;
                queue[rear][1] = ny;
                rear++;
            }
        }
    }

    return 0;
}