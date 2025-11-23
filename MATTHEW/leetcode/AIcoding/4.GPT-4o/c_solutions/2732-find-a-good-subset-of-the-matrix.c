int maxGood(int** grid, int gridSize, int* gridColSize){
    int maxCount = 0;
    for (int mask = 0; mask < (1 << gridSize); mask++) {
        int count = 0;
        int valid = 1;
        for (int i = 0; i < gridSize; i++) {
            if (mask & (1 << i)) {
                count++;
                for (int j = 0; j < gridSize; j++) {
                    if (mask & (1 << j) && grid[i][j] == 1) {
                        valid = 0;
                        break;
                    }
                }
            }
            if (!valid) break;
        }
        if (valid) {
            maxCount = maxCount < count ? count : maxCount;
        }
    }
    return maxCount;
}