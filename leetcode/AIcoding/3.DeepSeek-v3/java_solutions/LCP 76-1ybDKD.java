class Solution {
    public int[][] magicalBoard(int m, int n) {
        int[][] board = new int[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                board[i][j] = (i + j) % 2 == 0 ? 1 : 0;
            }
        }
        return board;
    }
}