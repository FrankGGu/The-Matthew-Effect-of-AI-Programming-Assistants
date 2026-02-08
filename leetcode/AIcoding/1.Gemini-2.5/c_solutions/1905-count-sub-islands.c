void dfs(int** grid1, int** grid2, int r, int c, int rows, int cols, int* is_sub_island) {
    if (r < 0 || r >= rows || c < 0 || c >= cols || grid2[r][c] == 0) {
        return;
    }

    if (grid1[r][c] == 0) {
        *is_sub_island = 0;
    }

    grid2[r][c] = 0; // Mark as visited

    dfs(grid1, grid2, r + 1, c, rows, cols, is_sub_island);
    dfs(grid1, grid2, r - 1, c, rows, cols, is_sub_island);
    dfs(grid1, grid2, r, c + 1, rows, cols, is_sub_island);
    dfs(grid1, grid2, r, c - 1, rows, cols, is_sub_island);
}

int countSubIslands(int** grid1, int grid1Size, int* grid1ColSize, int** grid2, int grid2Size, int* grid2ColSize) {
    int rows = grid1Size;
    int cols = grid1ColSize[0]; 

    int sub_island_count = 0;

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            if (grid2[r][c] == 1) {
                int is_current_island_sub = 1; 
                dfs(grid1, grid2, r, c, rows, cols, &is_current_island_sub);
                if (is_current_island_sub == 1) {
                    sub_island_count++;
                }
            }
        }
    }

    return sub_island_count;
}