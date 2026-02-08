public class Solution {

import java.util.*;

public class Solution {
    public int[] getBiggestThree(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        TreeSet<Integer> set = new TreeSet<>(Collections.reverseOrder());

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                set.add(grid[i][j]);
                for (int k = 1; i + k < m && i - k >= 0 && j + k < n && j - k >= 0; k++) {
                    int sum = 0;
                    for (int d = 0; d <= k; d++) {
                        sum += grid[i - k + d][j - k + d];
                        sum += grid[i - k + d][j + k - d];
                        sum += grid[i + k - d][j - k + d];
                        sum += grid[i + k - d][j + k - d];
                    }
                    sum -= grid[i - k][j] + grid[i + k][j] + grid[i][j - k] + grid[i][j + k];
                    set.add(sum);
                }
            }
        }

        int[] result = new int[Math.min(3, set.size())];
        int index = 0;
        for (int val : set) {
            if (index < 3) {
                result[index++] = val;
            } else {
                break;
            }
        }
        return result;
    }
}
}