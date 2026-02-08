class Solution {
    public int[] findColumnWidth(String[][] grid) {
        int[] widths = new int[grid[0].length];
        for (int j = 0; j < grid[0].length; j++) {
            for (int i = 0; i < grid.length; i++) {
                widths[j] = Math.max(widths[j], grid[i][j].length());
            }
        }
        return widths;
    }
}