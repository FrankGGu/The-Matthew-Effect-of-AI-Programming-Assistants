typedef struct {
    int x, y;
} Point;

int** fillGrid(int m, int n, int* returnSize, int** returnColumnSizes) {
    int** grid = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        grid[i] = (int*)malloc(n * sizeof(int));
    }

    Point directions[4] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int dir = 0, x = 0, y = 0, num = 1, total = m * n;

    while (num <= total) {
        grid[x][y] = num++;
        int nextX = x + directions[dir].x;
        int nextY = y + directions[dir].y;

        if (nextX < 0 || nextX >= m || nextY < 0 || nextY >= n || grid[nextX][nextY] != 0) {
            dir = (dir + 1) % 4;
            nextX = x + directions[dir].x;
            nextY = y + directions[dir].y;
        }

        x = nextX;
        y = nextY;
    }

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    return grid;
}