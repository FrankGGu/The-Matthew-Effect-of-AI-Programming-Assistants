public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> rotateGrid(int[][] grid, int k) {
        int rows = grid.length;
        int cols = grid[0].length;
        List<List<Integer>> result = new ArrayList<>();

        for (int i = 0; i < rows; i++) {
            result.add(new ArrayList<>());
        }

        int top = 0, bottom = rows - 1, left = 0, right = cols - 1;

        while (top <= bottom && left <= right) {
            List<Integer> cycle = new ArrayList<>();

            // Traverse from left to right on top row
            for (int i = left; i <= right; i++) {
                cycle.add(grid[top][i]);
            }

            // Traverse from top+1 to bottom on right column
            for (int i = top + 1; i <= bottom; i++) {
                cycle.add(grid[i][right]);
            }

            // Traverse from right-1 to left on bottom row, if top != bottom
            if (top < bottom) {
                for (int i = right - 1; i >= left; i--) {
                    cycle.add(grid[bottom][i]);
                }
            }

            // Traverse from bottom-1 to top+1 on left column, if left != right
            if (left < right) {
                for (int i = bottom - 1; i > top; i--) {
                    cycle.add(grid[i][left]);
                }
            }

            int n = cycle.size();
            if (n == 0) break;

            k = k % n;
            if (k == 0) {
                // No rotation needed, copy back
                int idx = 0;
                for (int i = left; i <= right; i++) {
                    result.get(top).add(cycle.get(idx++));
                }
                for (int i = top + 1; i <= bottom; i++) {
                    result.get(i).add(cycle.get(idx++));
                }
                if (top < bottom) {
                    for (int i = right - 1; i >= left; i--) {
                        result.get(bottom).add(cycle.get(idx++));
                    }
                }
                if (left < right) {
                    for (int i = bottom - 1; i > top; i--) {
                        result.get(i).add(cycle.get(idx++));
                    }
                }
                continue;
            }

            // Rotate the cycle
            List<Integer> rotated = new ArrayList<>();
            for (int i = 0; i < n; i++) {
                rotated.add(cycle.get((i + k) % n));
            }

            int idx = 0;
            // Fill back into the grid
            for (int i = left; i <= right; i++) {
                result.get(top).add(rotated.get(idx++));
            }
            for (int i = top + 1; i <= bottom; i++) {
                result.get(i).add(rotated.get(idx++));
            }
            if (top < bottom) {
                for (int i = right - 1; i >= left; i--) {
                    result.get(bottom).add(rotated.get(idx++));
                }
            }
            if (left < right) {
                for (int i = bottom - 1; i > top; i--) {
                    result.get(i).add(rotated.get(idx++));
                }
            }

            top++;
            bottom--;
            left++;
            right--;
        }

        return result;
    }
}
}