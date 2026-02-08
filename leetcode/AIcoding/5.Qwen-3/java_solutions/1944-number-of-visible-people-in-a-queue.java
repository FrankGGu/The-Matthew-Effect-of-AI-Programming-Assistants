public class Solution {

import java.util.*;

public class Solution {
    public int[] canSeePersonsAtFrontOfQueue(int[] heights) {
        int n = heights.length;
        int[] result = new int[n];
        Stack<Integer> stack = new Stack<>();

        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && heights[stack.peek()] < heights[i]) {
                stack.pop();
            }
            if (!stack.isEmpty()) {
                result[i] = stack.peek();
            } else {
                result[i] = 0;
            }
            stack.push(i);
        }

        return result;
    }
}
}