int minHealth;

void dfs(int** grid, int gridSize, int* gridColSize, int x, int y, int health) {
    if (health <= 0) return;
    if (x == gridSize - 1 && y == *gridColSize - 1) {
        if (health > minHealth) minHealth = health;
        return;
    }

    int temp = grid[x][y];
    grid[x][y] = -1;

    int dirs[4][2] = {{0,1}, {1,0}, {0,-1}, {-1,0}};
    for (int i = 0; i < 4; i++) {
        int nx = x + dirs[i][0];
        int ny = y + dirs[i][1];
        if (nx >= 0 && nx < gridSize && ny >= 0 && ny < *gridColSize && grid[nx][ny] != -1) {
            dfs(grid, gridSize, gridColSize, nx, ny, health + grid[nx][ny]);
        }
    }

    grid[x][y] = temp;
}

int minimumHealth(int** grid, int gridSize, int* gridColSize) {
    minHealth = -1000000000;
    int startHealth = 1 - grid[0][0];
    if (startHealth <= 0) startHealth = 1;

    dfs(grid, gridSize, gridColSize, 0, 0, startHealth);

    return minHealth;
}