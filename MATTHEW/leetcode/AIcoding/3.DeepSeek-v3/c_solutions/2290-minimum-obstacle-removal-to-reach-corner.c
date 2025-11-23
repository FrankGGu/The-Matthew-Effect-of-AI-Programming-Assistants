int minObstacles(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int** dist = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    int dirs[4][2] = {{0,1}, {1,0}, {0,-1}, {-1,0}};

    typedef struct {
        int x;
        int y;
        int cost;
    } Node;

    Node* deque = (Node*)malloc(m * n * sizeof(Node));
    int front = 0, rear = 0;

    dist[0][0] = 0;
    deque[rear++] = (Node){0, 0, 0};

    while (front < rear) {
        Node curr = deque[front++];
        int x = curr.x, y = curr.y, cost = curr.cost;

        if (x == m-1 && y == n-1) {
            for (int i = 0; i < m; i++) free(dist[i]);
            free(dist);
            free(deque);
            return cost;
        }

        for (int i = 0; i < 4; i++) {
            int nx = x + dirs[i][0];
            int ny = y + dirs[i][1];

            if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                int newCost = cost + grid[nx][ny];
                if (newCost < dist[nx][ny]) {
                    dist[nx][ny] = newCost;
                    if (grid[nx][ny] == 0) {
                        deque[--front] = (Node){nx, ny, newCost};
                    } else {
                        deque[rear++] = (Node){nx, ny, newCost};
                    }
                }
            }
        }
    }

    for (int i = 0; i < m; i++) free(dist[i]);
    free(dist);
    free(deque);
    return dist[m-1][n-1];
}