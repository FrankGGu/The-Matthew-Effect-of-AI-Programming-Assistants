typedef struct {
    int bx, by, sx, sy;
} State;

int minPushBox(char** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int bx, by, sx, sy, tx, ty;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 'B') {
                bx = i;
                by = j;
            } else if (grid[i][j] == 'S') {
                sx = i;
                sy = j;
            } else if (grid[i][j] == 'T') {
                tx = i;
                ty = j;
            }
        }
    }

    int dirs[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
    int visited[m][n][m][n];
    memset(visited, 0, sizeof(visited));

    State queue[40000];
    int front = 0, rear = 0;
    queue[rear++] = (State){bx, by, sx, sy};
    visited[bx][by][sx][sy] = 1;

    int steps = 0;
    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            State cur = queue[front++];
            if (cur.bx == tx && cur.by == ty) {
                return steps;
            }

            for (int d = 0; d < 4; d++) {
                int nsx = cur.sx + dirs[d][0];
                int nsy = cur.sy + dirs[d][1];
                if (nsx < 0 || nsx >= m || nsy < 0 || nsy >= n || grid[nsx][nsy] == '#') {
                    continue;
                }

                if (nsx == cur.bx && nsy == cur.by) {
                    int nbx = cur.bx + dirs[d][0];
                    int nby = cur.by + dirs[d][1];
                    if (nbx < 0 || nbx >= m || nby < 0 || nby >= n || grid[nbx][nby] == '#') {
                        continue;
                    }
                    if (!visited[nbx][nby][nsx][nsy]) {
                        visited[nbx][nby][nsx][nsy] = 1;
                        queue[rear++] = (State){nbx, nby, nsx, nsy};
                    }
                } else {
                    if (!visited[cur.bx][cur.by][nsx][nsy]) {
                        visited[cur.bx][cur.by][nsx][nsy] = 1;
                        queue[front - 1] = (State){cur.bx, cur.by, nsx, nsy};
                        front--;
                    }
                }
            }
        }
        steps++;
    }

    return -1;
}