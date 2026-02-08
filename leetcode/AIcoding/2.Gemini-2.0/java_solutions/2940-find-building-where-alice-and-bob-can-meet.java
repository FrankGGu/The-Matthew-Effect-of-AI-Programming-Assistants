import java.util.Arrays;

class Solution {
    public int[] leftmostBuildingQueries(int[] heights, int[][] queries) {
        int n = heights.length;
        int m = queries.length;
        Integer[] idx = new Integer[m];
        for (int i = 0; i < m; i++) {
            idx[i] = i;
        }
        Arrays.sort(idx, (i, j) -> {
            int a = queries[i][0];
            int b = queries[i][1];
            int c = queries[j][0];
            int d = queries[j][1];
            return Math.max(a, b) - Math.max(c, d);
        });

        int[] ans = new int[m];
        Arrays.fill(ans, -1);

        for (int i : idx) {
            int a = queries[i][0];
            int b = queries[i][1];

            if (a == b) {
                if (heights[a] == heights[b]) {
                    ans[i] = a;
                    continue;
                }
            }

            if (heights[a] < heights[b]) {
                int temp = a;
                a = b;
                b = temp;
            }

            int maxH = Math.max(heights[a], heights[b]);

            for (int k = 0; k < n; k++) {
                if (k > Math.max(a, b) && heights[k] > maxH) {
                    ans[i] = k;
                    break;
                }
            }
        }

        return ans;
    }
}