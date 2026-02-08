import java.util.Stack;

public class Solution {
    public int[] canSeePersonsCount(int[] heights) {
        int n = heights.length;
        int[] result = new int[n];
        Stack<Integer> stack = new Stack<>();

        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && stack.peek() <= heights[i]) {
                stack.pop();
            }
            result[i] = stack.size();
            if (!stack.isEmpty()) {
                result[i]++;
            }
            stack.push(heights[i]);
        }

        return result;
    }
}