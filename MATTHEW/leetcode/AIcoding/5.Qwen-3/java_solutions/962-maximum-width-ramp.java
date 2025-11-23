public class Solution {

import java.util.*;

public class Solution {
    public int maxWidthRamp(int[] A) {
        int n = A.length;
        int maxWidth = 0;
        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < n; i++) {
            if (stack.isEmpty() || A[i] < A[stack.peek()]) {
                stack.push(i);
            }
        }

        for (int j = n - 1; j >= 0; j--) {
            while (!stack.isEmpty() && A[j] >= A[stack.peek()]) {
                int i = stack.pop();
                maxWidth = Math.max(maxWidth, j - i);
            }
        }

        return maxWidth;
    }
}
}