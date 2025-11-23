class Solution {
    public List<List<Integer>> shiftGrid(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;
        k = k % (m * n);
        List<List<Integer>> result = new ArrayList<>();

        for (int i = 0; i < m; i++) {
            result.add(new ArrayList<>());
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int newIdx = (i * n + j + k) % (m * n);
                int newRow = newIdx / n;
                int newCol = newIdx % n;
                result.get(newRow).add(grid[i][j]);
            }
        }

        return result;
    }
}