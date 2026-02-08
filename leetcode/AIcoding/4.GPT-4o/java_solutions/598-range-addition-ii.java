class Solution {
    public int maxCount(int m, int n, int[][] ops) {
        int rows = m, cols = n;
        for (int[] op : ops) {
            rows = Math.min(rows, op[0]);
            cols = Math.min(cols, op[1]);
        }
        return rows * cols;
    }
}