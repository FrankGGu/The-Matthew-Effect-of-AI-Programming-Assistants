int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int minimumArea(char** grid, int gridSize, int* gridColSize) {
    int min_r = gridSize;
    int max_r = -1;
    int min_c = gridColSize[0];
    int max_c = -1;

    int found_one = 0;

    int num_cols = gridColSize[0];

    for (int r = 0; r < gridSize; r++) {
        for (int c = 0; c < num_cols; c++) {
            if (grid[r][c] == '1') {
                found_one = 1;
                min_r = min(min_r, r);
                max_r = max(max_r, r);
                min_c = min(min_c, c);
                max_c = max(max_c, c);
            }
        }
    }

    if (!found_one) {
        return 0;
    } else {
        return (max_r - min_r + 1) * (max_c - min_c + 1);
    }
}