typedef struct {
    int x, y;
} Point;

int maximumSafenessFactor(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    if (grid[0][0] == 1 || grid[n-1][n-1] == 1) return 0;

    int** dist = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    Point* queue = (Point*)malloc(n * n * sizeof(Point));
    int front = 0, rear = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                dist[i][j] = 0;
                queue[rear++] = (Point){i, j};
            }
        }
    }

    int dirs[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    while (front < rear) {
        Point curr = queue[front++];
        for (int d = 0; d < 4; d++) {
            int nx = curr.x + dirs[d][0];
            int ny = curr.y + dirs[d][1];
            if (nx >= 0 && nx < n && ny >= 0 && ny < n && dist[nx][ny] == INT_MAX) {
                dist[nx][ny] = dist[curr.x][curr.y] + 1;
                queue[rear++] = (Point){nx, ny};
            }
        }
    }

    int left = 0, right = n * 2, ans = 0;
    while (left <= right) {
        int mid = left + (right - left) / 2;

        int** visited = (int**)malloc(n * sizeof(int*));
        for (int i = 0; i < n; i++) {
            visited[i] = (int*)calloc(n, sizeof(int));
        }

        front = 0, rear = 0;
        if (dist[0][0] >= mid) {
            visited[0][0] = 1;
            queue[rear++] = (Point){0, 0};
        }

        int found = 0;
        while (front < rear) {
            Point curr = queue[front++];
            if (curr.x == n-1 && curr.y == n-1) {
                found = 1;
                break;
            }
            for (int d = 0; d < 4; d++) {
                int nx = curr.x + dirs[d][0];
                int ny = curr.y + dirs[d][1];
                if (nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[nx][ny] && dist[nx][ny] >= mid) {
                    visited[nx][ny] = 1;
                    queue[rear++] = (Point){nx, ny};
                }
            }
        }

        for (int i = 0; i < n; i++) free(visited[i]);
        free(visited);

        if (found) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    for (int i = 0; i < n; i++) free(dist[i]);
    free(dist);
    free(queue);

    return ans;
}