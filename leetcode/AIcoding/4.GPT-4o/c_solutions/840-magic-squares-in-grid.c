int numMagicSquaresInside(int** grid, int gridSize, int* gridColSize) {
    int count = 0;
    for (int i = 0; i <= gridSize - 3; i++) {
        for (int j = 0; j <= gridColSize[0] - 3; j++) {
            int magic[3][3] = {
                {grid[i][j], grid[i][j + 1], grid[i][j + 2]},
                {grid[i + 1][j], grid[i + 1][j + 1], grid[i + 1][j + 2]},
                {grid[i + 2][j], grid[i + 2][j + 1], grid[i + 2][j + 2]}
            };
            int sum = 0, valid = 1;
            for (int k = 0; k < 3; k++) {
                sum += magic[k][0];
            }
            for (int k = 0; k < 3; k++) {
                if (magic[k][0] + magic[k][1] + magic[k][2] != sum) valid = 0;
                if (magic[0][k] + magic[1][k] + magic[2][k] != sum) valid = 0;
            }
            if (magic[0][0] + magic[1][1] + magic[2][2] != sum) valid = 0;
            if (magic[0][2] + magic[1][1] + magic[2][0] != sum) valid = 0;
            for (int k = 1; k <= 9; k++) {
                int found = 0;
                for (int x = 0; x < 3; x++) {
                    for (int y = 0; y < 3; y++) {
                        if (magic[x][y] == k) found = 1;
                    }
                }
                if (!found) valid = 0;
            }
            count += valid;
        }
    }
    return count;
}