class Solution {
    public int[][] differenceOfDistinctValues(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] res = new int[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                Set<Integer> topLeft = new HashSet<>();
                Set<Integer> bottomRight = new HashSet<>();

                int r = i - 1, c = j - 1;
                while (r >= 0 && c >= 0) {
                    topLeft.add(grid[r][c]);
                    r--;
                    c--;
                }

                r = i + 1;
                c = j + 1;
                while (r < m && c < n) {
                    bottomRight.add(grid[r][c]);
                    r++;
                    c++;
                }

                res[i][j] = Math.abs(topLeft.size() - bottomRight.size());
            }
        }

        return res;
    }
}