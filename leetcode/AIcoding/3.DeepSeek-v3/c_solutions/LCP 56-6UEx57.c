typedef struct {
    int x;
    int y;
    int cost;
} Node;

int dirs[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
char dirChars[4] = {'>', '<', 'v', '^'};

int conveyorBelt(char** matrix, int matrixSize, int* start, int startSize, int* end, int endSize) {
    int m = matrixSize, n = strlen(matrix[0]);
    int** dist = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    Node* deque = (Node*)malloc(m * n * sizeof(Node));
    int front = 0, rear = 0;

    int sx = start[0], sy = start[1];
    int ex = end[0], ey = end[1];

    dist[sx][sy] = 0;
    deque[rear++] = (Node){sx, sy, 0};

    while (front < rear) {
        Node cur = deque[front++];
        int x = cur.x, y = cur.y, cost = cur.cost;

        if (x == ex && y == ey) {
            for (int i = 0; i < m; i++) free(dist[i]);
            free(dist);
            free(deque);
            return cost;
        }

        for (int i = 0; i < 4; i++) {
            int nx = x + dirs[i][0];
            int ny = y + dirs[i][1];
            if (nx < 0 || nx >= m || ny < 0 || ny >= n) continue;

            int newCost = cost + (matrix[x][y] == dirChars[i] ? 0 : 1);

            if (newCost < dist[nx][ny]) {
                dist[nx][ny] = newCost;
                if (newCost == cost) {
                    deque[--front] = (Node){nx, ny, newCost};
                } else {
                    deque[rear++] = (Node){nx, ny, newCost};
                }
            }
        }
    }

    int res = dist[ex][ey];
    for (int i = 0; i < m; i++) free(dist[i]);
    free(dist);
    free(deque);
    return res;
}