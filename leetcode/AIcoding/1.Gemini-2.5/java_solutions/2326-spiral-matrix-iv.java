class Solution {
    public int[][] spiralMatrix(int m, int n, ListNode head) {
        int[][] matrix = new int[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                matrix[i][j] = -1;
            }
        }

        int rowStart = 0;
        int rowEnd = m - 1;
        int colStart = 0;
        int colEnd = n - 1;

        while (head != null && rowStart <= rowEnd && colStart <= colEnd) {
            // Traverse right
            for (int c = colStart; c <= colEnd; c++) {
                if (head == null) break;
                matrix[rowStart][c] = head.val;
                head = head.next;
            }
            rowStart++;

            // Traverse down
            for (int r = rowStart; r <= rowEnd; r++) {
                if (head == null) break;
                matrix[r][colEnd] = head.val;
                head = head.next;
            }
            colEnd--;

            // Traverse left
            if (rowStart <= rowEnd) {
                for (int c = colEnd; c >= colStart; c--) {
                    if (head == null) break;
                    matrix[rowEnd][c] = head.val;
                    head = head.next;
                }
            }
            rowEnd--;

            // Traverse up
            if (colStart <= colEnd) {
                for (int r = rowEnd; r >= rowStart; r--) {
                    if (head == null) break;
                    matrix[r][colStart] = head.val;
                    head = head.next;
                }
            }
            colStart++;
        }

        return matrix;
    }
}