class Solution {
    public List<List<Integer>> shiftGrid(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;
        k = k % (m * n);

        List<List<Integer>> res = new ArrayList<>();
        for (int i = 0; i < m; i++) {
            res.add(new ArrayList<>());
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int newIndex = (i * n + j + k) % (m * n);
                int newRow = newIndex / n;
                int newCol = newIndex % n;
                res.get(newRow).add(grid[i][j]);
            }
        }

        return res;
    }
}