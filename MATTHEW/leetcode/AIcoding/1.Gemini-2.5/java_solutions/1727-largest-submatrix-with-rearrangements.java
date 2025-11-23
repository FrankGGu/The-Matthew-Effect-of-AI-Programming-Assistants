import java.util.Arrays;

class Solution {
    public int largestSubmatrix(int[][] matrix) {
        int m = matrix.length;
        int n = matrix[0].length;
        int maxArea = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (matrix[i][j] == 1 && i > 0) {
                    matrix[i][j] += matrix[i - 1][j];
                }
            }

            int[] currentHeights = new int[n];
            for (int j = 0; j < n; j++) {
                currentHeights[j] = matrix[i][j];
            }

            Arrays.sort(currentHeights);

            for (int k = 0; k < n; k++) {
                int height = currentHeights[k];
                int width = n - k;
                maxArea = Math.max(maxArea, height * width);
            }
        }

        return maxArea;
    }
}