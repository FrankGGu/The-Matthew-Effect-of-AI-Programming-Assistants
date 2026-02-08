int findChampion(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    for (int i = 0; i < n; i++) {
        int isChampion = 1;
        for (int j = 0; j < n; j++) {
            if (i == j) {
                continue;
            }
            if (grid[i][j] == 0) {
                isChampion = 0;
                break;
            }
        }
        if (isChampion) {
            return i;
        }
    }
    return -1;
}