import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[][] rotateGrid(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;

        int numLayers = Math.min(m, n) / 2;

        for (int l = 0; l < numLayers; l++) {
            int r_start = l;
            int c_start = l;
            int r_end = m - 1 - l;
            int c_end = n - 1 - l;

            List<Integer> layerElements = new ArrayList<>();

            // Extract elements in clockwise order
            // Top row (left to right)
            for (int j = c_start; j <= c_end; j++) {
                layerElements.add(grid[r_start][j]);
            }
            // Right column (top to bottom)
            for (int i = r_start + 1; i <= r_end; i++) {
                layerElements.add(grid[i][c_end]);
            }
            // Bottom row (right to left)
            if (r_start != r_end) { // Avoid double counting for single row
                for (int j = c_end - 1; j >= c_start; j--) {
                    layerElements.add(grid[r_end][j]);
                }
            }
            // Left column (bottom to top)
            if (c_start != c_end) { // Avoid double counting for single column
                for (int i = r_end - 1; i >= r_start + 1; i--) {
                    layerElements.add(grid[i][c_start]);
                }
            }

            int layerSize = layerElements.size();
            if (layerSize == 0) { // Should not happen if numLayers is calculated correctly, but good for safety
                continue;
            }
            int effectiveK = k % layerSize;

            // Place elements back into the grid in counter-clockwise rotated order
            // The element at original index 'idx' moves to '(idx - effectiveK + layerSize) % layerSize'
            // So, the element that ends up at 'new_idx' was originally at '(new_idx + effectiveK) % layerSize'
            int currentIdx = 0;
            // Top row (left to right)
            for (int j = c_start; j <= c_end; j++) {
                grid[r_start][j] = layerElements.get((currentIdx + effectiveK) % layerSize);
                currentIdx++;
            }
            // Right column (top to bottom)
            for (int i = r_start + 1; i <= r_end; i++) {
                grid[i][c_end] = layerElements.get((currentIdx + effectiveK) % layerSize);
                currentIdx++;
            }
            // Bottom row (right to left)
            if (r_start != r_end) {
                for (int j = c_end - 1; j >= c_start; j--) {
                    grid[r_end][j] = layerElements.get((currentIdx + effectiveK) % layerSize);
                    currentIdx++;
                }
            }
            // Left column (bottom to top)
            if (c_start != c_end) {
                for (int i = r_end - 1; i >= r_start + 1; i--) {
                    grid[i][c_start] = layerElements.get((currentIdx + effectiveK) % layerSize);
                    currentIdx++;
                }
            }
        }

        return grid;
    }
}