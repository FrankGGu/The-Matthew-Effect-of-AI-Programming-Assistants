import java.util.*;

class Solution {
    public int[] getBiggestThree(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        Set<Integer> sums = new HashSet<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int d = 0; d < Math.min(m, n); d++) {
                    int sum = 0;
                    boolean valid = true;
                    for (int k = 0; k <= d; k++) {
                        if (i - k < 0 || j - k < 0 || j + k >= n) {
                            valid = false;
                            break;
                        }
                        sum += grid[i - k][j] + grid[i + k][j];
                        if (k > 0) {
                            sum += grid[i - k][j - k] + grid[i - k][j + k];
                        }
                    }
                    if (valid) {
                        sums.add(sum);
                    }
                }
            }
        }

        List<Integer> sortedSums = new ArrayList<>(sums);
        Collections.sort(sortedSums, Collections.reverseOrder());

        int[] result = new int[Math.min(3, sortedSums.size())];
        for (int i = 0; i < result.length; i++) {
            result[i] = sortedSums.get(i);
        }

        return result;
    }
}