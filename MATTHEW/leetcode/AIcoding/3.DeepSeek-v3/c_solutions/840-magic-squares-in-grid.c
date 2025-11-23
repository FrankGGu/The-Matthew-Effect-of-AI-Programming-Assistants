int numMagicSquaresInside(int** grid, int gridSize, int* gridColSize) {
    if (gridSize < 3 || *gridColSize < 3) return 0;

    int count = 0;
    for (int i = 0; i <= gridSize - 3; i++) {
        for (int j = 0; j <= *gridColSize - 3; j++) {
            int used[16] = {0};
            int valid = 1;

            for (int x = i; x < i + 3; x++) {
                for (int y = j; y < j + 3; y++) {
                    int num = grid[x][y];
                    if (num < 1 || num > 9 || used[num]) {
                        valid = 0;
                        break;
                    }
                    used[num] = 1;
                }
                if (!valid) break;
            }
            if (!valid) continue;

            int sum = grid[i][j] + grid[i][j+1] + grid[i][j+2];

            if (grid[i+1][j] + grid[i+1][j+1] + grid[i+1][j+2] != sum) continue;
            if (grid[i+2][j] + grid[i+2][j+1] + grid[i+2][j+2] != sum) continue;

            if (grid[i][j] + grid[i+1][j] + grid[i+2][j] != sum) continue;
            if (grid[i][j+1] + grid[i+1][j+1] + grid[i+2][j+1] != sum) continue;
            if (grid[i][j+2] + grid[i+1][j+2] + grid[i+2][j+2] != sum) continue;

            if (grid[i][j] + grid[i+1][j+1] + grid[i+2][j+2] != sum) continue;
            if (grid[i][j+2] + grid[i+1][j+1] + grid[i+2][j] != sum) continue;

            count++;
        }
    }
    return count;
}