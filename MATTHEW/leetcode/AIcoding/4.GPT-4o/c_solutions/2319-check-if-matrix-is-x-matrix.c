bool checkXMatrix(int** grid, int gridSize, int* gridColSize){
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if ((i == j || i + j == gridSize - 1) && grid[i][j] == 0) {
                return false;
            }
            if (i != j && i + j != gridSize - 1 && grid[i][j] != 0) {
                return false;
            }
        }
    }
    return true;
}