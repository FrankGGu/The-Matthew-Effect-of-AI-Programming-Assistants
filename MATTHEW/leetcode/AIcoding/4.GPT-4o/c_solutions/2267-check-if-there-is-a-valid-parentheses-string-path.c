bool hasValidPath(int row, int col, int open, int close, int** grid, int gridSize, int* gridColSize) {
    if (open < close) return false;
    if (row == gridSize - 1 && col == gridColSize[0] - 1) return open == close;
    if (row < 0 || col < 0 || row >= gridSize || col >= gridColSize[0]) return false;

    int c = grid[row][col];
    if (c == 1) open++;
    else if (c == 2) close++;
    else if (c == 3) { open++; close++; }

    int result = hasValidPath(row + 1, col, open, close, grid, gridSize, gridColSize) ||
                 hasValidPath(row, col + 1, open, close, grid, gridSize, gridColSize) ||
                 hasValidPath(row - 1, col, open, close, grid, gridSize, gridColSize) ||
                 hasValidPath(row, col - 1, open, close, grid, gridSize, gridColSize);

    return result;
}

bool hasValidPath(int** grid, int gridSize, int* gridColSize) {
    return hasValidPath(0, 0, 0, 0, grid, gridSize, gridColSize);
}