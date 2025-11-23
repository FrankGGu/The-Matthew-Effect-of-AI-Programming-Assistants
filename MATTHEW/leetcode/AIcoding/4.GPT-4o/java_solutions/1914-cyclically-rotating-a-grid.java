class Solution {
    public void rotateGrid(int[][] grid, int k) {
        int rows = grid.length, cols = grid[0].length;
        int layers = Math.min(rows, cols) / 2;

        for (int layer = 0; layer < layers; layer++) {
            int perimeter = 2 * (rows + cols - 4 * layer) - 4;
            int effectiveK = k % perimeter;

            int[] layerElements = new int[perimeter];
            int index = 0;

            for (int j = layer; j < cols - layer; j++) {
                layerElements[index++] = grid[layer][j];
            }
            for (int j = layer + 1; j < rows - layer; j++) {
                layerElements[index++] = grid[j][cols - layer - 1];
            }
            for (int j = cols - layer - 1; j >= layer; j--) {
                layerElements[index++] = grid[rows - layer - 1][j];
            }
            for (int j = rows - layer - 2; j > layer; j--) {
                layerElements[index++] = grid[j][layer];
            }

            for (int j = 0; j < perimeter; j++) {
                int newIndex = (j + effectiveK) % perimeter;
                if (j < cols - 2 * layer) {
                    grid[layer][layer + j] = layerElements[newIndex];
                } else if (j < cols - 2 * layer + rows - 2 * layer - 2) {
                    grid[layer + j - (cols - 2 * layer)][cols - layer - 1] = layerElements[newIndex];
                } else if (j < 2 * (cols - 2 * layer) + rows - 2 * layer - 2) {
                    grid[rows - layer - 1][cols - layer - 1 - (j - (cols - 2 * layer + rows - 2 * layer - 2))] = layerElements[newIndex];
                } else {
                    grid[rows - layer - 1 - (j - (2 * (cols - 2 * layer) + rows - 2 * layer - 2))][layer] = layerElements[newIndex];
                }
            }
        }
    }
}