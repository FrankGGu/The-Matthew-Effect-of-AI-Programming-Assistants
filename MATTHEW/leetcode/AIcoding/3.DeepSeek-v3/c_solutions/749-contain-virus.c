int g[50][50];
int visited[50][50];
int walls[50][50];
int regions[2500][2];
int regions_size;
int cols;

int dir[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

void dfs(int** grid, int gridSize, int* gridColSize, int i, int j, int* perimeter, int* infected) {
    if (i < 0 || i >= gridSize || j < 0 || j >= *gridColSize || visited[i][j] == 1 || grid[i][j] == 2) {
        return;
    }
    if (grid[i][j] == 0) {
        (*perimeter)++;
        if (walls[i][j] == 0) {
            walls[i][j] = 1;
            (*infected)++;
        }
        return;
    }
    visited[i][j] = 1;
    regions[regions_size][0] = i;
    regions[regions_size][1] = j;
    regions_size++;
    for (int k = 0; k < 4; k++) {
        int x = i + dir[k][0];
        int y = j + dir[k][1];
        dfs(grid, gridSize, gridColSize, x, y, perimeter, infected);
    }
}

int containVirus(int** grid, int gridSize, int* gridColSize) {
    int res = 0;
    cols = *gridColSize;
    while (1) {
        memset(visited, 0, sizeof(visited));
        memset(walls, 0, sizeof(walls));
        int max_infected = -1;
        int max_perimeter = 0;
        int max_region_index = -1;
        int regions_count = 0;
        for (int i = 0; i < gridSize; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1 && visited[i][j] == 0) {
                    regions_size = 0;
                    int perimeter = 0;
                    int infected = 0;
                    dfs(grid, gridSize, gridColSize, i, j, &perimeter, &infected);
                    if (infected > max_infected) {
                        max_infected = infected;
                        max_perimeter = perimeter;
                        max_region_index = regions_count;
                    }
                    for (int k = 0; k < regions_size; k++) {
                        g[regions[k][0]][regions[k][1]] = regions_count;
                    }
                    regions_count++;
                }
            }
        }
        if (max_infected == 0) break;
        res += max_perimeter;
        for (int i = 0; i < gridSize; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1 && visited[i][j] == 1 && g[i][j] == max_region_index) {
                    grid[i][j] = 2;
                }
            }
        }
        for (int i = 0; i < gridSize; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1 && visited[i][j] == 1) {
                    for (int k = 0; k < 4; k++) {
                        int x = i + dir[k][0];
                        int y = j + dir[k][1];
                        if (x >= 0 && x < gridSize && y >= 0 && y < cols && grid[x][y] == 0) {
                            grid[x][y] = 1;
                        }
                    }
                }
            }
        }
    }
    return res;
}