typedef struct {
    int x;
    int y;
    int k;
    int steps;
} State;

int shortestPath(int** grid, int gridSize, int* gridColSize, int k) {
    int m = gridSize, n = gridColSize[0];
    if (m == 1 && n == 1) return 0;

    int dirs[4][2] = {{0,1}, {1,0}, {0,-1}, {-1,0}};
    int visited[m][n][k+1];
    memset(visited, 0, sizeof(visited));

    State queue[m * n * (k + 1)];
    int front = 0, rear = 0;

    queue[rear++] = (State){0, 0, k, 0};
    visited[0][0][k] = 1;

    while (front < rear) {
        State curr = queue[front++];

        for (int i = 0; i < 4; i++) {
            int nx = curr.x + dirs[i][0];
            int ny = curr.y + dirs[i][1];

            if (nx < 0 || nx >= m || ny < 0 || ny >= n) continue;

            if (nx == m - 1 && ny == n - 1) return curr.steps + 1;

            int nk = curr.k - grid[nx][ny];

            if (nk >= 0 && !visited[nx][ny][nk]) {
                visited[nx][ny][nk] = 1;
                queue[rear++] = (State){nx, ny, nk, curr.steps + 1};
            }
        }
    }

    return -1;
}