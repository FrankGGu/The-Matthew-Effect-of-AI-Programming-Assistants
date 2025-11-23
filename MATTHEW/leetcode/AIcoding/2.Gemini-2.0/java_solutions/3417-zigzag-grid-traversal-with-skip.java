class Solution {
    public int[] solve(int n, int m, int k) {
        int[] result = new int[n * m - k];
        int index = 0;
        int row = 0, col = 0;
        boolean down = true;
        int skipCount = 0;

        while (index < n * m - k) {
            if (row >= 0 && row < n && col >= 0 && col < m) {
                if (skipCount < k) {
                    skipCount++;
                } else {
                    result[index++] = row * m + col + 1;
                }
            }

            if (down) {
                row++;
                col--;
                if (row == n) {
                    row = n - 2;
                    col = col + 2;
                    down = false;
                } else if (col < 0) {
                    col = 1;
                    row = row - 1;
                    down = false;
                }
            } else {
                row--;
                col++;
                if (col == m) {
                    col = m - 2;
                    row = row + 2;
                    down = true;
                } else if (row < 0) {
                    row = 1;
                    col = col - 1;
                    down = true;
                }
            }
        }

        return result;
    }
}