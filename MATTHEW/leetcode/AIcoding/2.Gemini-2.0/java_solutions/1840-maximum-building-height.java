import java.util.Arrays;

class Solution {
    public int maxBuilding(int n, int[][] restrictions) {
        Arrays.sort(restrictions, (a, b) -> a[0] - b[0]);

        int m = restrictions.length;
        long[] heights = new long[m];
        for (int i = 0; i < m; i++) {
            heights[i] = restrictions[i][1];
        }

        if (m == 0) {
            return n - 1;
        }

        long[] left = new long[m];
        left[0] = heights[0];
        for (int i = 1; i < m; i++) {
            left[i] = Math.min(heights[i], left[i - 1] + (restrictions[i][0] - restrictions[i - 1][0]));
        }

        long[] right = new long[m];
        right[m - 1] = heights[m - 1];
        for (int i = m - 2; i >= 0; i--) {
            right[i] = Math.min(heights[i], right[i + 1] + (restrictions[i + 1][0] - restrictions[i][0]));
        }

        long[] finalHeights = new long[m];
        for (int i = 0; i < m; i++) {
            finalHeights[i] = Math.min(left[i], right[i]);
        }

        long max = Math.max(0, finalHeights[0] + restrictions[0][0] - 1);
        for (int i = 0; i < m - 1; i++) {
            long diff = restrictions[i + 1][0] - restrictions[i][0];
            long h1 = finalHeights[i];
            long h2 = finalHeights[i + 1];
            long maxHeight = Math.max(h1, h2) + (diff - Math.abs(h1 - h2)) / 2;
            max = Math.max(max, maxHeight);
        }

        max = Math.max(max, finalHeights[m - 1] + (n - restrictions[m - 1][0]));

        return (int) max;
    }
}