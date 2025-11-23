int d[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

typedef struct {
    int x, y, time;
} Node;

int swimInWater(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int left = grid[0][0], right = n * n - 1;

    while (left < right) {
        int mid = left + (right - left) / 2;
        int visited[n][n];
        memset(visited, 0, sizeof(visited));

        Node queue[n * n];
        int front = 0, rear = 0;

        if (grid[0][0] <= mid) {
            queue[rear++] = (Node){0, 0, grid[0][0]};
            visited[0][0] = 1;
        }

        int found = 0;
        while (front < rear) {
            Node cur = queue[front++];
            if (cur.x == n - 1 && cur.y == n - 1) {
                found = 1;
                break;
            }

            for (int i = 0; i < 4; i++) {
                int nx = cur.x + d[i][0];
                int ny = cur.y + d[i][1];

                if (nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[nx][ny] && grid[nx][ny] <= mid) {
                    visited[nx][ny] = 1;
                    queue[rear++] = (Node){nx, ny, grid[nx][ny]};
                }
            }
        }

        if (found) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}