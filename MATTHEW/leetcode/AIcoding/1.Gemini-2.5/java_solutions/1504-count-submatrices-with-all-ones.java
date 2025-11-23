class Solution {
    public int numSubmat(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;
        int totalCount = 0;
        int[] heights = new int[n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (mat[i][j] == 1) {
                    heights[j]++;
                } else {
                    heights[j] = 0;
                }
            }

            for (int j = 0; j < n; j++) {
                int minHeight = heights[j];
                for (int k = j; k >= 0; k--) {
                    minHeight = Math.min(minHeight, heights[k]);
                    totalCount += minHeight;
                }
            }
        }

        return totalCount;
    }
}