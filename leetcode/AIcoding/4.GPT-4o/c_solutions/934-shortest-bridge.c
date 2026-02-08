#define MAX 100
typedef struct {
    int x, y;
} Point;

int queue[MAX * MAX][2];
int front, rear;

void bfs(int** grid, int n, int m, int x, int y, int* visited) {
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    front = 0;
    rear = 0;
    queue[rear][0] = x;
    queue[rear][1] = y;
    rear++;
    visited[x * m + y] = 1;

    while (front < rear) {
        Point p = {queue[front][0], queue[front][1]};
        front++;

        for (int i = 0; i < 4; i++) {
            int nx = p.x + directions[i][0];
            int ny = p.y + directions[i][1];
            if (nx >= 0 && nx < n && ny >= 0 && ny < m && grid[nx][ny] == 1 && !visited[nx * m + ny]) {
                visited[nx * m + ny] = 1;
                queue[rear][0] = nx;
                queue[rear][1] = ny;
                rear++;
            }
        }
    }
}

int shortestBridge(int** grid, int gridSize, int* gridColSize) {
    int visited[MAX * MAX] = {0};
    int found = 0;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            if (grid[i][j] == 1 && !found) {
                bfs(grid, gridSize, *gridColSize, i, j, visited);
                found = 1;
            }
        }
    }

    int steps = 0;
    while (found) {
        found = 0;
        for (int i = 0; i < rear; i++) {
            Point p = {queue[i][0], queue[i][1]};
            for (int j = 0; j < 4; j++) {
                int nx = p.x + directions[j][0];
                int ny = p.y + directions[j][1];
                if (nx >= 0 && nx < gridSize && ny >= 0 && ny < *gridColSize) {
                    if (grid[nx][ny] == 1 && !visited[nx * (*gridColSize) + ny]) {
                        return steps;
                    }
                    if (grid[nx][ny] == 0 && !visited[nx * (*gridColSize) + ny]) {
                        visited[nx * (*gridColSize) + ny] = 1;
                        queue[rear][0] = nx;
                        queue[rear][1] = ny;
                        rear++;
                        found = 1;
                    }
                }
            }
        }
        steps++;
    }

    return -1;
}