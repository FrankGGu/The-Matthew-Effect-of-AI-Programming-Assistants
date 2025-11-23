public class Solution {

import java.util.*;

public class Solution {
    public int maximizeArea(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int maxArea = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1) {
                    int size = 1;
                    while (i + size < rows && j + size < cols) {
                        boolean canExpand = true;
                        for (int k = 0; k <= size; k++) {
                            if (grid[i + size][j + k] != 1 || grid[i + k][j + size] != 1) {
                                canExpand = false;
                                break;
                            }
                        }
                        if (!canExpand) break;
                        size++;
                    }
                    maxArea = Math.max(maxArea, size * size);
                }
            }
        }

        return maxArea;
    }
}
}