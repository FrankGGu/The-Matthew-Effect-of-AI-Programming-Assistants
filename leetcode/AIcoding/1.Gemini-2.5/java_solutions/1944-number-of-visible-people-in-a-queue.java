import java.util.Stack;

class Solution {
    public int[] canSeePersonsCount(int[] heights) {
        int n = heights.length;
        int[] ans = new int[n];
        Stack<Integer> stack = new Stack<>(); // Stores indices of people

        // Iterate from right to left
        for (int i = n - 1; i >= 0; i--) {
            int count = 0;
            // Pop all people from the stack who are shorter than the current person (heights[i]).
            // These popped people are visible to heights[i].
            while (!stack.isEmpty() && heights[stack.peek()] < heights[i]) {
                stack.pop();
                count++;
            }

            // If the stack is not empty after popping, the person at the top of the stack
            // is taller than or equal to heights[i]. This person is also visible to heights[i]
            // and blocks the view of any further people to their right.
            if (!stack.isEmpty()) {
                count++;
            }

            ans[i] = count;
            // Push the current person's index onto the stack.
            // The stack maintains a monotonically decreasing sequence of heights from bottom to top.
            stack.push(i);
        }

        return ans;
    }
}