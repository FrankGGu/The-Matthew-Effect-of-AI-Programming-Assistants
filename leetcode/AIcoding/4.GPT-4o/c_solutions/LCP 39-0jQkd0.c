int maxArea(int** grid, int gridSize, int* gridColSize) {
    int max_area = 0;
    int rows = gridSize, cols = gridColSize[0];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                int area = 0;
                for (int k = i; k < rows && grid[k][j] == 1; k++) {
                    for (int l = j; l < cols && grid[k][l] == 1; l++) {
                        area++;
                    }
                }
                if (area > max_area) {
                    max_area = area;
                }
            }
        }
    }

    return max_area;
}