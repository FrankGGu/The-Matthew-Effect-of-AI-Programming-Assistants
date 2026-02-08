int countInfected(int** grid, int gridSize, int* gridColSize) {
    int directions[4][2] = {{0,1}, {1,0}, {0,-1}, {-1,0}};
    int count = 0;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] == 1) {
                count++;
            }
        }
    }

    int result = 0;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] == 0) {
                int infected = 0;
                for (int d = 0; d < 4; d++) {
                    int ni = i + directions[d][0];
                    int nj = j + directions[d][1];
                    if (ni >= 0 && ni < gridSize && nj >= 0 && nj < gridColSize[i] && grid[ni][nj] == 1) {
                        infected = 1;
                        break;
                    }
                }
                if (infected) {
                    result++;
                }
            }
        }
    }

    return result;
}