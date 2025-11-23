int minChanges(int** grid, int gridSize, int* gridColSize) {
    int count1 = 0, count2 = 0;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[0]; j++) {
            if ((i + j) % 2 == grid[i][j]) {
                count1++;
            } else {
                count2++;
            }
        }
    }

    return count1 < count2 ? count1 : count2;
}