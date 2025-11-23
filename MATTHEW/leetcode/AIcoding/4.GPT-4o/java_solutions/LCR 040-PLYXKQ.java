class Solution {
    public int maximalRectangle(char[][] matrix) {
        if (matrix.length == 0) return 0;
        int maxArea = 0;
        int[] heights = new int[matrix[0].length];

        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[0].length; j++) {
                heights[j] = matrix[i][j] == '1' ? heights[j] + 1 : 0;
            }
            maxArea = Math.max(maxArea, largestRectangleArea(heights));
        }

        return maxArea;
    }

    private int largestRectangleArea(int[] heights) {
        int maxArea = 0;
        int[] stack = new int[heights.length + 1];
        int index = 0;

        for (int i = 0; i < heights.length; i++) {
            while (index > 0 && heights[stack[index - 1]] > heights[i]) {
                int h = heights[stack[--index]];
                int w = index == 0 ? i : i - stack[index - 1] - 1;
                maxArea = Math.max(maxArea, h * w);
            }
            stack[index++] = i;
        }

        while (index > 0) {
            int h = heights[stack[--index]];
            int w = index == 0 ? heights.length : heights.length - stack[index - 1] - 1;
            maxArea = Math.max(maxArea, h * w);
        }

        return maxArea;
    }
}