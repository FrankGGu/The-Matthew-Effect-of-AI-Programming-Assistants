int dir[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

void dfs(int** grid, int gridSize, int* gridColSize, int i, int j, int** visited, int** queue, int* rear) {
    if (i < 0 || i >= gridSize || j < 0 || j >= gridColSize[0] || visited[i][j] || grid[i][j] == 0) {
        return;
    }
    visited[i][j] = 1;
    queue[(*rear)][0] = i;
    queue[(*rear)++][1] = j;
    for (int k = 0; k < 4; k++) {
        int x = i + dir[k][0];
        int y = j + dir[k][1];
        dfs(grid, gridSize, gridColSize, x, y, visited, queue, rear);
    }
}

int shortestBridge(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = gridColSize[0];

    int** visited = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        visited[i] = (int*)calloc(m, sizeof(int));
    }

    int** queue = (int**)malloc(n * m * sizeof(int*));
    for (int i = 0; i < n * m; i++) {
        queue[i] = (int*)malloc(2 * sizeof(int));
    }
    int front = 0, rear = 0;

    int found = 0;
    for (int i = 0; i < n && !found; i++) {
        for (int j = 0; j < m && !found; j++) {
            if (grid[i][j] == 1) {
                dfs(grid, gridSize, gridColSize, i, j, visited, queue, &rear);
                found = 1;
            }
        }
    }

    int steps = 0;
    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int x = queue[front][0];
            int y = queue[front][1];
            front++;

            for (int k = 0; k < 4; k++) {
                int nx = x + dir[k][0];
                int ny = y + dir[k][1];

                if (nx >= 0 && nx < n && ny >= 0 && ny < m && !visited[nx][ny]) {
                    if (grid[nx][ny] == 1) {
                        return steps;
                    }
                    visited[nx][ny] = 1;
                    queue[rear][0] = nx;
                    queue[rear++][1] = ny;
                }
            }
        }
        steps++;
    }

    for (int i = 0; i < n; i++) {
        free(visited[i]);
    }
    free(visited);

    for (int i = 0; i < n * m; i++) {
        free(queue[i]);
    }
    free(queue);

    return -1;
}