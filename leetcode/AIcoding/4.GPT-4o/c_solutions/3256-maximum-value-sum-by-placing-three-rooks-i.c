int maxValue(int** grid, int gridSize, int* gridColSize) {
    int max_sum = 0;
    for (int r1 = 0; r1 < gridSize; r1++) {
        for (int c1 = 0; c1 < gridColSize[0]; c1++) {
            for (int r2 = 0; r2 < gridSize; r2++) {
                for (int c2 = 0; c2 < gridColSize[0]; c2++) {
                    if (r1 == r2 || c1 == c2) continue;
                    for (int r3 = 0; r3 < gridSize; r3++) {
                        for (int c3 = 0; c3 < gridColSize[0]; c3++) {
                            if ((r1 == r3 || c1 == c3) || (r2 == r3 || c2 == c3)) continue;
                            int sum = grid[r1][c1] + grid[r2][c2] + grid[r3][c3];
                            if (sum > max_sum) {
                                max_sum = sum;
                            }
                        }
                    }
                }
            }
        }
    }
    return max_sum;
}