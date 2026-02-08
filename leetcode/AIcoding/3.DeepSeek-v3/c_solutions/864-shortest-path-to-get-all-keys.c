typedef struct {
    int x;
    int y;
    int keys;
} State;

int shortestPathAllKeys(char** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int totalKeys = 0;
    int startX = 0, startY = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == '@') {
                startX = i;
                startY = j;
            } else if (grid[i][j] >= 'a' && grid[i][j] <= 'f') {
                totalKeys = fmax(totalKeys, grid[i][j] - 'a' + 1);
            }
        }
    }

    int target = (1 << totalKeys) - 1;
    int visited[m][n][1 << totalKeys];
    memset(visited, 0, sizeof(visited));

    int dirs[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    State queue[m * n * (1 << totalKeys)];
    int front = 0, rear = 0;

    queue[rear].x = startX;
    queue[rear].y = startY;
    queue[rear].keys = 0;
    rear++;
    visited[startX][startY][0] = 1;

    int steps = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            State current = queue[front++];

            if (current.keys == target) {
                return steps;
            }

            for (int d = 0; d < 4; d++) {
                int nx = current.x + dirs[d][0];
                int ny = current.y + dirs[d][1];
                int nkeys = current.keys;

                if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] != '#') {
                    char cell = grid[nx][ny];

                    if (cell >= 'A' && cell <= 'F') {
                        int keyNeeded = cell - 'A';
                        if (!(nkeys & (1 << keyNeeded))) {
                            continue;
                        }
                    }

                    if (cell >= 'a' && cell <= 'f') {
                        nkeys |= (1 << (cell - 'a'));
                    }

                    if (!visited[nx][ny][nkeys]) {
                        visited[nx][ny][nkeys] = 1;
                        queue[rear].x = nx;
                        queue[rear].y = ny;
                        queue[rear].keys = nkeys;
                        rear++;
                    }
                }
            }
        }
        steps++;
    }

    return -1;
}