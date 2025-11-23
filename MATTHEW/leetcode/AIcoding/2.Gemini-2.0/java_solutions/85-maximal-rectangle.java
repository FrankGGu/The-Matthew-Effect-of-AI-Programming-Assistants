import java.util.Stack;

class Solution {
    public int maximalRectangle(char[][] matrix) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return 0;
        }

        int rows = matrix.length;
        int cols = matrix[0].length;
        int maxArea = 0;
        int[] heights = new int[cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (matrix[i][j] == '1') {
                    heights[j] += 1;
                } else {
                    heights[j] = 0;
                }
            }
            maxArea = Math.max(maxArea, largestRectangleArea(heights));
        }

        return maxArea;
    }

    private int largestRectangleArea(int[] heights) {
        Stack<Integer> stack = new Stack<>();
        int maxArea = 0;
        int i = 0;
        while (i < heights.length || !stack.isEmpty()) {
            if (stack.isEmpty() || (i < heights.length && heights[i] >= heights[stack.peek()])) {
                stack.push(i);
                i++;
            } else {
                int top = stack.pop();
                int area = heights[top] * (stack.isEmpty() ? i : (i - stack.peek() - 1));
                maxArea = Math.max(maxArea, area);
            }
        }
        return maxArea;
    }
}