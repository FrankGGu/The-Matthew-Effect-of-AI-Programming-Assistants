int max(int a, int b) {
    return a > b ? a : b;
}

int surfaceArea(int** grid, int gridSize, int* gridColSize) {
    int total_area = 0;
    int N = gridSize;
    int M = gridColSize[0];

    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < M; ++j) {
            int h = grid[i][j];

            if (h == 0) {
                continue;
            }

            total_area += 2; // Top and bottom faces

            // Lateral faces
            total_area += max(0, h - (i > 0 ? grid[i-1][j] : 0)); // North face
            total_area += max(0, h - (i < N - 1 ? grid[i+1][j] : 0)); // South face
            total_area += max(0, h - (j > 0 ? grid[i][j-1] : 0)); // West face
            total_area += max(0, h - (j < M - 1 ? grid[i][j+1] : 0)); // East face
        }
    }

    return total_area;
}