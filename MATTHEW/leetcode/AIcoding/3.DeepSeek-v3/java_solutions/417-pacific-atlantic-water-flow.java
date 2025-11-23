class Solution {
    private static final int[][] DIRECTIONS = new int[][]{{0, 1}, {1, 0}, {-1, 0}, {0, -1}};
    private int numRows;
    private int numCols;

    public List<List<Integer>> pacificAtlantic(int[][] heights) {
        numRows = heights.length;
        numCols = heights[0].length;

        boolean[][] pacificReachable = new boolean[numRows][numCols];
        boolean[][] atlanticReachable = new boolean[numRows][numCols];

        for (int i = 0; i < numRows; i++) {
            dfs(i, 0, pacificReachable, heights);
            dfs(i, numCols - 1, atlanticReachable, heights);
        }

        for (int i = 0; i < numCols; i++) {
            dfs(0, i, pacificReachable, heights);
            dfs(numRows - 1, i, atlanticReachable, heights);
        }

        List<List<Integer>> result = new ArrayList<>();
        for (int i = 0; i < numRows; i++) {
            for (int j = 0; j < numCols; j++) {
                if (pacificReachable[i][j] && atlanticReachable[i][j]) {
                    result.add(Arrays.asList(i, j));
                }
            }
        }
        return result;
    }

    private void dfs(int row, int col, boolean[][] reachable, int[][] heights) {
        reachable[row][col] = true;
        for (int[] dir : DIRECTIONS) {
            int newRow = row + dir[0];
            int newCol = col + dir[1];
            if (newRow < 0 || newRow >= numRows || newCol < 0 || newCol >= numCols || reachable[newRow][newCol]) {
                continue;
            }
            if (heights[newRow][newCol] >= heights[row][col]) {
                dfs(newRow, newCol, reachable, heights);
            }
        }
    }
}