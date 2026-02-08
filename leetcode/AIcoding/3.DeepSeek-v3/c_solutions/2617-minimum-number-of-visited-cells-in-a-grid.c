typedef struct {
    int row;
    int col;
    int steps;
} Node;

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int minimumVisitedCells(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    if (m == 1 && n == 1) return 1;

    int** dist = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[i][j] = INT_MAX;
        }
    }
    dist[0][0] = 1;

    Node* queue = (Node*)malloc(m * n * sizeof(Node));
    int front = 0, rear = 0;
    queue[rear++] = (Node){0, 0, 1};

    while (front < rear) {
        Node curr = queue[front++];
        int r = curr.row;
        int c = curr.col;
        int steps = curr.steps;

        if (steps > dist[r][c]) continue;

        int maxRight = min(n - 1, c + grid[r][c]);
        for (int j = c + 1; j <= maxRight; j++) {
            if (dist[r][j] > steps + 1) {
                dist[r][j] = steps + 1;
                queue[rear++] = (Node){r, j, steps + 1};
            }
        }

        int maxDown = min(m - 1, r + grid[r][c]);
        for (int i = r + 1; i <= maxDown; i++) {
            if (dist[i][c] > steps + 1) {
                dist[i][c] = steps + 1;
                queue[rear++] = (Node){i, c, steps + 1};
            }
        }
    }

    int result = dist[m-1][n-1];

    for (int i = 0; i < m; i++) {
        free(dist[i]);
    }
    free(dist);
    free(queue);

    return result == INT_MAX ? -1 : result;
}