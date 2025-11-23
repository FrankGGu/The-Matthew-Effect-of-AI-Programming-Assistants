class Solution {
    public int largestSubmatrix(int[][] matrix) {
        int rows = matrix.length, cols = matrix[0].length;
        int[][] heights = new int[rows][cols];
        int maxArea = 0;

        for (int j = 0; j < cols; j++) {
            for (int i = 0; i < rows; i++) {
                heights[i][j] = (i == 0 ? 0 : heights[i - 1][j]) + matrix[i][j];
            }
        }

        for (int i = 0; i < rows; i++) {
            Arrays.sort(heights[i]);
            for (int j = cols - 1; j >= 0; j--) {
                maxArea = Math.max(maxArea, heights[i][j] * (cols - j));
            }
        }

        return maxArea;
    }
}