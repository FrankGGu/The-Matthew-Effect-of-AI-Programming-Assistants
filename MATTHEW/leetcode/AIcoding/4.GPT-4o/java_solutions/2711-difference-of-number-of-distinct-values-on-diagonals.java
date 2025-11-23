class Solution {
    public int[] differenceOfDistinctValues(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[] result = new int[m * n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                Set<Integer> leftDiagonal = new HashSet<>();
                Set<Integer> rightDiagonal = new HashSet<>();
                for (int k = 1; k < Math.min(m, n); k++) {
                    if (i - k >= 0 && j - k >= 0) {
                        leftDiagonal.add(grid[i - k][j - k]);
                    }
                    if (i + k < m && j + k < n) {
                        rightDiagonal.add(grid[i + k][j + k]);
                    }
                }
                result[i * n + j] = leftDiagonal.size() - rightDiagonal.size();
            }
        }
        return result;
    }
}