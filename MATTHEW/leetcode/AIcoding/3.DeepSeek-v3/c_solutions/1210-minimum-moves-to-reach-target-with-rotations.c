typedef struct {
    int x;
    int y;
    int dir; // 0 for horizontal, 1 for vertical
} State;

int minimumMoves(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    if (grid[n-1][n-1] == 1 || grid[n-1][n-2] == 1) return -1;

    int visited[n][n][2];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            visited[i][j][0] = 0;
            visited[i][j][1] = 0;
        }
    }

    State queue[n*n*2];
    int front = 0, rear = 0;

    queue[rear++] = (State){0, 0, 0};
    visited[0][0][0] = 1;

    int steps = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            State curr = queue[front++];
            int x = curr.x, y = curr.y, dir = curr.dir;

            if (x == n-1 && y == n-2 && dir == 0) {
                return steps;
            }

            // Move right
            if (y + 1 < n && grid[x][y+1] == 0 && 
                (dir == 0 || (dir == 1 && y + 1 < n && grid[x+1][y+1] == 0))) {
                if (!visited[x][y+1][dir]) {
                    visited[x][y+1][dir] = 1;
                    queue[rear++] = (State){x, y+1, dir};
                }
            }

            // Move down
            if (x + 1 < n && grid[x+1][y] == 0 && 
                (dir == 1 || (dir == 0 && x + 1 < n && grid[x+1][y+1] == 0))) {
                if (!visited[x+1][y][dir]) {
                    visited[x+1][y][dir] = 1;
                    queue[rear++] = (State){x+1, y, dir};
                }
            }

            // Rotate clockwise
            if (dir == 0 && x + 1 < n && grid[x+1][y] == 0 && grid[x+1][y+1] == 0) {
                if (!visited[x][y][1]) {
                    visited[x][y][1] = 1;
                    queue[rear++] = (State){x, y, 1};
                }
            }

            // Rotate counterclockwise
            if (dir == 1 && y + 1 < n && grid[x][y+1] == 0 && grid[x+1][y+1] == 0) {
                if (!visited[x][y][0]) {
                    visited[x][y][0] = 1;
                    queue[rear++] = (State){x, y, 0};
                }
            }
        }
        steps++;
    }

    return -1;
}