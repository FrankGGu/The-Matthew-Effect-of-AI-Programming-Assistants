int countNegatives(int** grid, int gridSize, int* gridColSize) {
    int count = 0;
    int rows = gridSize;
    int cols = gridColSize[0];

    for (int i = 0; i < rows; i++) {
        int left = 0, right = cols - 1;
        int firstNegative = cols;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (grid[i][mid] < 0) {
                firstNegative = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        count += (cols - firstNegative);
    }

    return count;
}