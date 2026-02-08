int countNegatives(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0]; 

    int count = 0;
    int r = 0; 
    int c = n - 1; 

    while (r < m && c >= 0) {
        if (grid[r][c] < 0) {
            count += (m - r);
            c--;
        } else {
            r++;
        }
    }

    return count;
}