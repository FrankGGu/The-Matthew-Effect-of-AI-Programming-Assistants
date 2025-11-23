public class Solution {

import java.util.*;

public class Solution {
    public int longestVShapedDiagonalSegment(int[][] matrix) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return 0;
        }

        int rows = matrix.length;
        int cols = matrix[0].length;
        int maxLen = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                int len = 1;
                int x = i - 1, y = j + 1;
                while (x >= 0 && y < cols && matrix[x][y] == matrix[i][j]) {
                    len++;
                    x--;
                    y++;
                }
                x = i + 1;
                y = j - 1;
                while (x < rows && y >= 0 && matrix[x][y] == matrix[i][j]) {
                    len++;
                    x++;
                    y--;
                }
                maxLen = Math.max(maxLen, len);
            }
        }

        return maxLen;
    }
}
}