typedef struct {
    int x;
    int y;
    int time;
} Node;

int minTime(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    if (grid[0][1] > 1 && grid[1][0] > 1) return -1;

    int dirs[4][2] = {{0,1}, {0,-1}, {1,0}, {-1,0}};
    int** visited = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        visited[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) visited[i][j] = INT_MAX;
    }

    Node* queue = (Node*)malloc(m * n * sizeof(Node));
    int front = 0, rear = 0;

    queue[rear++] = (Node){0, 0, 0};
    visited[0][0] = 0;

    while (front < rear) {
        Node curr = queue[front++];
        int x = curr.x, y = curr.y, time = curr.time;

        if (x == m-1 && y == n-1) {
            for (int i = 0; i < m; i++) free(visited[i]);
            free(visited);
            free(queue);
            return time;
        }

        for (int i = 0; i < 4; i++) {
            int nx = x + dirs[i][0], ny = y + dirs[i][1];
            if (nx < 0 || nx >= m || ny < 0 || ny >= n) continue;

            int nextTime = time + 1;
            if (grid[nx][ny] > nextTime) {
                int wait = grid[nx][ny] - nextTime;
                if (wait % 2 == 0) nextTime = grid[nx][ny];
                else nextTime = grid[nx][ny] + 1;
            }

            if (nextTime < visited[nx][ny]) {
                visited[nx][ny] = nextTime;
                queue[rear++] = (Node){nx, ny, nextTime};
            }
        }
    }

    for (int i = 0; i < m; i++) free(visited[i]);
    free(visited);
    free(queue);
    return -1;
}