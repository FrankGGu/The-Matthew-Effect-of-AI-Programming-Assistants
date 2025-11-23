public class Solution {

import java.util.*;

public class Solution {
    public int countSubmatrices(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] prefix = new int[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (i == 0 && j == 0) {
                    prefix[i][j] = grid[i][j];
                } else if (i == 0) {
                    prefix[i][j] = prefix[i][j - 1] + grid[i][j];
                } else if (j == 0) {
                    prefix[i][j] = prefix[i - 1][j] + grid[i][j];
                } else {
                    prefix[i][j] = prefix[i - 1][j] + prefix[i][j - 1] - prefix[i - 1][j - 1] + grid[i][j];
                }
            }
        }

        int count = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int x = i; x < m; x++) {
                    for (int y = j; y < n; y++) {
                        int sum = prefix[x][y];
                        if (i > 0) sum -= prefix[i - 1][y];
                        if (j > 0) sum -= prefix[x][j - 1];
                        if (i > 0 && j > 0) sum += prefix[i - 1][j - 1];
                        if (sum < k) {
                            count++;
                        }
                    }
                }
            }
        }

        return count;
    }
}
}