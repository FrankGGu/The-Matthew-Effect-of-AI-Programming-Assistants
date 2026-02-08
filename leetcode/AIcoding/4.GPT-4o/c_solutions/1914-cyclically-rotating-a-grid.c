void rotateGrid(int** grid, int gridSize, int* gridColSize, int k) {
    int rows = gridSize, cols = *gridColSize;
    int layers = fmin(rows, cols) / 2;

    for (int layer = 0; layer < layers; layer++) {
        int perimeter = 2 * (rows + cols - 4 * layer) - 4;
        int effectiveK = k % perimeter;

        int* temp = malloc(perimeter * sizeof(int));
        int index = 0;

        for (int j = layer; j < cols - layer; j++) {
            temp[index++] = grid[layer][j];
        }
        for (int i = layer + 1; i < rows - layer; i++) {
            temp[index++] = grid[i][cols - layer - 1];
        }
        for (int j = cols - layer - 1; j >= layer; j--) {
            if (rows - layer - 1 > layer) {
                temp[index++] = grid[rows - layer - 1][j];
            }
        }
        for (int i = rows - layer - 2; i > layer; i--) {
            if (cols - layer - 1 > layer) {
                temp[index++] = grid[i][layer];
            }
        }

        for (int i = 0; i < perimeter; i++) {
            grid[layer + (i + effectiveK) / (cols - 2 * layer)][layer + (i + effectiveK) % (cols - 2 * layer)] = temp[i];
        }

        free(temp);
    }
}