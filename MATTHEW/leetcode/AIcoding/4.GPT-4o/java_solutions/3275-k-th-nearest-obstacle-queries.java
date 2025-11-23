class Solution {
    public int[] kNearestObstacles(int[][] obstacles, int[][] queries) {
        int m = 100001;
        boolean[] grid = new boolean[m];
        for (int[] obstacle : obstacles) {
            grid[obstacle[0]] = true;
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int k = queries[i][1];
            int x = queries[i][0];
            int count = 0;
            for (int j = 0; j < m; j++) {
                if (grid[x + j] && count < k) {
                    count++;
                }
                if (grid[x - j] && count < k) {
                    count++;
                }
                if (count == k) {
                    result[i] = j;
                    break;
                }
            }
        }
        return result;
    }
}