import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public int largestRectangleArea(int[] heights) {
        int n = heights.length;
        if (n == 0) {
            return 0;
        }

        int maxArea = 0;
        Deque<Integer> stack = new ArrayDeque<>(); // Stores indices of bars

        // Iterate through all bars, including a virtual bar of height 0 at the end
        // to ensure all elements in the stack are processed.
        for (int i = 0; i <= n; i++) {
            int currentHeight = (i == n) ? 0 : heights[i];

            // While the stack is not empty and the current bar is shorter than
            // or equal to the bar at the top of the stack, pop from the stack.
            while (!stack.isEmpty() && currentHeight <= heights[stack.peek()]) {
                int h = heights[stack.pop()]; // Height of the bar being popped
                // Calculate the width for the rectangle with height 'h'.
                // The left boundary is stack.peek() (the first bar to the left that is shorter) + 1.
                // The right boundary is i - 1 (the current bar's index - 1, as current bar is shorter).
                // So, width = (i - 1) - (stack.peek() + 1) + 1 = i - stack.peek() - 1.
                // If stack is empty, it means 'h' is the shortest bar so far,
                // and its left boundary extends to index -1. So width = i.
                int w = stack.isEmpty() ? i : i - stack.peek() - 1;
                maxArea = Math.max(maxArea, h * w);
            }
            stack.push(i); // Push current index onto the stack
        }

        return maxArea;
    }
}