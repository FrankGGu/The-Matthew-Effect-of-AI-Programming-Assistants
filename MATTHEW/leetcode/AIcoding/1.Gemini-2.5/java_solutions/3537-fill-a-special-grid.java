import java.util.TreeSet;

class Solution {
    public int[][] fillSpecialGrid(int n, int m) {
        int[][] grid = new int[n][m];
        TreeSet<Integer> availableNumbers = new TreeSet<>();
        for (int i = 1; i <= n * m; i++) {
            availableNumbers.add(i);
        }

        for (int r = 0; r < n; r++) {
            for (int c = 0; c < m; c++) {
                int minValNeeded = 1;
                if (r > 0) {
                    minValNeeded = Math.max(minValNeeded, grid[r - 1][c] + 1);
                }
                if (c > 0) {
                    minValNeeded = Math.max(minValNeeded, grid[r][c - 1] + 1);
                }

                Integer chosenValue = availableNumbers.ceiling(minValNeeded);
                grid[r][c] = chosenValue;
                availableNumbers.remove(chosenValue);
            }
        }

        return grid;
    }
}