class Solution {
    public int countSubmatrices(int[][] grid, int x, int y) {
        int m = grid.length;
        int n = grid[0].length;
        int count = 0;
        for (int r1 = 0; r1 < m; r1++) {
            for (int c1 = 0; c1 < n; c1++) {
                for (int r2 = r1; r2 < m; r2++) {
                    for (int c2 = c1; c2 < n; c2++) {
                        int xCount = 0;
                        int yCount = 0;
                        for (int i = r1; i <= r2; i++) {
                            for (int j = c1; j <= c2; j++) {
                                if (grid[i][j] == x) {
                                    xCount++;
                                } else if (grid[i][j] == y) {
                                    yCount++;
                                }
                            }
                        }
                        if (xCount == yCount) {
                            count++;
                        }
                    }
                }
            }
        }
        return count;
    }
}