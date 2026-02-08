public class Solution {
    public int minimumOperationsToWriteY(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int[][] count = new int[26][2];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                char c = (char) ('a' + grid[i][j]);
                if (isYPart(i, j, rows, cols)) {
                    count[grid[i][j]][0]++;
                } else {
                    count[grid[i][j]][1]++;
                }
            }
        }

        int minOps = Integer.MAX_VALUE;
        for (int i = 0; i < 26; i++) {
            int yCount = count[i][0];
            int otherCount = 0;
            for (int j = 0; j < 26; j++) {
                if (i != j) {
                    otherCount += count[j][1];
                }
            }
            int totalOps = (yCount + otherCount) - (count[i][0] + count[i][1]);
            minOps = Math.min(minOps, totalOps);
        }

        return minOps;
    }

    private boolean isYPart(int i, int j, int rows, int cols) {
        int midRow = rows / 2;
        int midCol = cols / 2;

        if (i <= midRow && j == midCol) {
            return true;
        }

        if (i > midRow && (i - midRow) == Math.abs(j - midCol)) {
            return true;
        }

        return false;
    }
}