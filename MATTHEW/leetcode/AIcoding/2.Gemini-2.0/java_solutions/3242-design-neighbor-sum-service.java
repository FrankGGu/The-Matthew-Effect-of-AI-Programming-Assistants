class NeighborSum {

    private int[][] grid;
    private int m;
    private int n;

    public NeighborSum(int[][] grid) {
        this.grid = grid;
        this.m = grid.length;
        this.n = grid[0].length;
    }

    public void update(int row, int col, int val) {
        grid[row][col] = val;
    }

    public int getSum(int row, int col) {
        int sum = 0;
        for (int i = Math.max(0, row - 1); i <= Math.min(m - 1, row + 1); i++) {
            for (int j = Math.max(0, col - 1); j <= Math.min(n - 1, col + 1); j++) {
                sum += grid[i][j];
            }
        }
        return sum;
    }
}