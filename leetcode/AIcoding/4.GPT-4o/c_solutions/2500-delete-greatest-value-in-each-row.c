int deleteGreatestValue(int** grid, int gridSize, int* gridColSize){
    int maxCol = gridColSize[0];
    int total = 0;

    for (int j = 0; j < maxCol; j++) {
        int maxVal = 0;
        for (int i = 0; i < gridSize; i++) {
            if (grid[i][j] > maxVal) {
                maxVal = grid[i][j];
            }
        }
        total += maxVal;
    }

    return total;
}