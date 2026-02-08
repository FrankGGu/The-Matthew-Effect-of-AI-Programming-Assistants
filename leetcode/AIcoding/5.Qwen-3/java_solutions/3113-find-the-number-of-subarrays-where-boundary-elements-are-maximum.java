public class Solution {

import java.util.*;

public class Solution {
    public int sumSubarrayMins(int[] arr) {
        int n = arr.length;
        int[] left = new int[n];
        int[] right = new int[n];

        Arrays.fill(left, -1);
        Arrays.fill(right, n);

        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < n; i++) {
            while (!stack.empty() && arr[stack.peek()] >= arr[i]) {
                stack.pop();
            }
            if (!stack.empty()) {
                left[i] = stack.peek();
            }
            stack.push(i);
        }

        stack = new Stack<>();

        for (int i = n - 1; i >= 0; i--) {
            while (!stack.empty() && arr[stack.peek()] > arr[i]) {
                stack.pop();
            }
            if (!stack.empty()) {
                right[i] = stack.peek();
            }
            stack.push(i);
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            result += arr[i] * (i - left[i]) * (right[i] - i);
        }

        return result;
    }
}
}