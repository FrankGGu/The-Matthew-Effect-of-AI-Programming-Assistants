#include <stdbool.h>
#include <stdlib.h>

typedef struct {
    int x, y;
} Point;

bool is_valid(int x, int y, int n, int m) {
    return x >= 0 && y >= 0 && x < n && y < m;
}

bool bfs(int** grid, int n, int m) {
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    Point queue[n * m];
    int front = 0, rear = 0;
    bool visited[n][m][2];

    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            visited[i][j][0] = visited[i][j][1] = false;

    queue[rear++] = (Point){0, 0};
    visited[0][0][0] = true;

    while (front < rear) {
        Point curr = queue[front++];
        if (curr.x == n - 1 && curr.y == m - 1)
            return true;

        for (int i = 0; i < 4; i++) {
            int nx = curr.x + directions[i][0];
            int ny = curr.y + directions[i][1];

            if (is_valid(nx, ny, n, m)) {
                if (grid[nx][ny] == 0 && !visited[nx][ny][0]) {
                    visited[nx][ny][0] = true;
                    queue[rear++] = (Point){nx, ny};
                } else if (grid[nx][ny] == 1 && !visited[nx][ny][1]) {
                    visited[nx][ny][1] = true;
                    queue[rear++] = (Point){nx, ny};
                }
            }
        }
    }
    return false;
}

bool canReach(int** grid, int gridSize, int* gridColSize) {
    if (grid[0][0] == 1 && gridSize == 1 && gridColSize[0] == 1) return true;
    return bfs(grid, gridSize, gridColSize[0]);
}