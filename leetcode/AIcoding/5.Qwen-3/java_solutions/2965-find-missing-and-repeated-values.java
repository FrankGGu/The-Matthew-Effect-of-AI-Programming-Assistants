public class Solution {
    public int[] findMissingAndRepeatedValues(int[][] grid, int n) {
        int[] result = new int[2];
        int[] count = new int[n * n + 1];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int num = grid[i][j];
                count[num]++;
            }
        }

        int repeated = -1;
        int missing = -1;

        for (int i = 1; i <= n * n; i++) {
            if (count[i] == 2) {
                repeated = i;
            } else if (count[i] == 0) {
                missing = i;
            }
        }

        result[0] = missing;
        result[1] = repeated;
        return result;
    }
}