import java.util.Arrays;

class Solution {
    public int[] countServers(int n, int[][] logs, int x, int[] queries) {
        int m = queries.length;
        int[] result = new int[m];
        for (int i = 0; i < m; i++) {
            int count = 0;
            for (int j = 0; j < n; j++) {
                boolean served = false;
                for (int[] log : logs) {
                    if (log[0] == j && queries[i] - log[1] <= x && queries[i] - log[1] >= 0) {
                        served = true;
                        break;
                    }
                }
                if (!served) {
                    count++;
                }
            }
            result[i] = count;
        }
        return result;
    }
}