#define MAX 100

bool isValid(int x, int y, int n, int m) {
    return x >= 0 && x < n && y >= 0 && y < m;
}

bool hasValidPath(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize, m = *gridColSize;
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int type[7][4] = {
        {}, 
        {0, 1, 2, 3}, 
        {0, 1}, 
        {1, 2}, 
        {2, 3}, 
        {3, 0}, 
        {0, 2}
    };
    bool visited[MAX][MAX] = {false};
    int queue[MAX * MAX][2], front = 0, rear = 0;

    if (grid[0][0] == 0 || grid[n - 1][m - 1] == 0) return false;
    queue[rear][0] = 0; queue[rear][1] = 0; rear++;
    visited[0][0] = true;

    while (front < rear) {
        int x = queue[front][0], y = queue[front][1];
        front++;

        if (x == n - 1 && y == m - 1) return true;

        for (int d = 0; d < 4; d++) {
            int nx = x + directions[d][0], ny = y + directions[d][1];
            if (isValid(nx, ny, n, m) && !visited[nx][ny]) {
                for (int i = 0; i < 2; i++) {
                    if (type[grid[x][y]][i] == d && type[grid[nx][ny]][i + 2] == (d + 2) % 4) {
                        queue[rear][0] = nx; queue[rear][1] = ny; rear++;
                        visited[nx][ny] = true;
                        break;
                    }
                }
            }
        }
    }

    return false;
}