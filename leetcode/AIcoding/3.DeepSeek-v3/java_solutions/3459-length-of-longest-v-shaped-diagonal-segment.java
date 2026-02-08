class Solution {
    public int longestVShapedDiagonalSegment(int[][] matrix) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return 0;
        }
        int m = matrix.length;
        int n = matrix[0].length;
        int maxLen = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int len = 1;
                int x = i, y = j;
                boolean isDecreasing = true;
                while (x + 1 < m && y + 1 < n) {
                    if (isDecreasing) {
                        if (matrix[x + 1][y + 1] < matrix[x][y]) {
                            len++;
                        } else if (matrix[x + 1][y + 1] > matrix[x][y]) {
                            isDecreasing = false;
                            len++;
                        } else {
                            break;
                        }
                    } else {
                        if (matrix[x + 1][y + 1] > matrix[x][y]) {
                            len++;
                        } else {
                            break;
                        }
                    }
                    x++;
                    y++;
                }
                if (len >= 3) {
                    maxLen = Math.max(maxLen, len);
                }
            }
        }

        return maxLen;
    }
}