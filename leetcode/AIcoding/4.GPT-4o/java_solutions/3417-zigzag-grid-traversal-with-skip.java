class Solution {
    public List<Integer> zigzagTraversal(int[][] grid) {
        List<Integer> result = new ArrayList<>();
        if (grid == null || grid.length == 0 || grid[0].length == 0) return result;

        int rows = grid.length, cols = grid[0].length;
        boolean leftToRight = true;

        for (int i = 0; i < rows; i++) {
            if (leftToRight) {
                for (int j = 0; j < cols; j++) {
                    result.add(grid[i][j]);
                }
            } else {
                for (int j = cols - 1; j >= 0; j--) {
                    result.add(grid[i][j]);
                }
            }
            leftToRight = !leftToRight;
        }
        return result;
    }
}