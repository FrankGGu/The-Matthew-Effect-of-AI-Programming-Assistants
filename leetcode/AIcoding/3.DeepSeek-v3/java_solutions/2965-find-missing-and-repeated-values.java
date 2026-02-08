class Solution {
    public int[] findMissingAndRepeatedValues(int[][] grid) {
        int n = grid.length;
        int[] count = new int[n * n + 1];
        int[] result = new int[2];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int num = grid[i][j];
                count[num]++;
                if (count[num] == 2) {
                    result[0] = num;
                }
            }
        }

        for (int i = 1; i <= n * n; i++) {
            if (count[i] == 0) {
                result[1] = i;
                break;
            }
        }

        return result;
    }
}