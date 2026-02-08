class Solution {
    private int minTiles = Integer.MAX_VALUE;

    public int tilingRectangle(int n, int m) {
        if (n == m) return 1;
        if (n > m) {
            int temp = n;
            n = m;
            m = temp;
        }

        minTiles = Integer.MAX_VALUE;
        boolean[][] used = new boolean[n][m];
        solve(used, 0, n, m, 0);
        return minTiles;
    }

    private void solve(boolean[][] used, int count, int n, int m, int row) {
        if (count >= minTiles) return;

        if (row == n) {
            minTiles = count;
            return;
        }

        int col = 0;
        while (col < m && used[row][col]) col++;
        if (col == m) {
            solve(used, count, n, m, row + 1);
            return;
        }

        int maxSide = Math.min(n - row, m - col);
        for (int side = maxSide; side >= 1; side--) {
            boolean canPlace = true;
            for (int i = row; i < row + side; i++) {
                for (int j = col; j < col + side; j++) {
                    if (used[i][j]) {
                        canPlace = false;
                        break;
                    }
                }
                if (!canPlace) break;
            }

            if (canPlace) {
                for (int i = row; i < row + side; i++) {
                    for (int j = col; j < col + side; j++) {
                        used[i][j] = true;
                    }
                }
                solve(used, count + 1, n, m, row);
                for (int i = row; i < row + side; i++) {
                    for (int j = col; j < col + side; j++) {
                        used[i][j] = false;
                    }
                }
            }
        }
    }
}