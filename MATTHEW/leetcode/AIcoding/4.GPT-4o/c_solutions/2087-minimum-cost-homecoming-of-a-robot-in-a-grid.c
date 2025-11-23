typedef struct {
    int x, y;
} Point;

int minCost(int** grid, int gridSize, int* gridColSize) {
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int costs[gridSize][*gridColSize];
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            costs[i][j] = INT_MAX;
        }
    }
    costs[0][0] = 0;

    struct {
        Point point;
        int cost;
    } queue[gridSize * (*gridColSize)];
    int front = 0, rear = 0;
    queue[rear++] = (struct {Point point; int cost;}){{0, 0}, 0};

    while (front < rear) {
        Point cur = queue[front].point;
        int curCost = queue[front++].cost;

        for (int d = 0; d < 4; d++) {
            int newX = cur.x + directions[d][0];
            int newY = cur.y + directions[d][1];
            if (newX >= 0 && newX < gridSize && newY >= 0 && newY < *gridColSize) {
                int newCost = curCost + (d + 1 == grid[cur.x][cur.y] ? 0 : 1);
                if (newCost < costs[newX][newY]) {
                    costs[newX][newY] = newCost;
                    queue[rear++] = (struct {Point point; int cost;}){{newX, newY}, newCost};
                }
            }
        }
    }

    return costs[gridSize - 1][*gridColSize - 1];
}