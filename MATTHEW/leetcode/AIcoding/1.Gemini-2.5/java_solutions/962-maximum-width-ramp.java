import java.util.Stack;

class Solution {
    public int maxWidthRamp(int[] A) {
        int N = A.length;
        if (N <= 1) {
            return 0;
        }

        Stack<Integer> stack = new Stack<>(); // Stores indices i such that A[i] is decreasing
        for (int i = 0; i < N; i++) {
            // Push index onto stack if it's empty or A[i] is smaller than the value at the top of the stack.
            // This ensures the stack stores indices of a decreasing subsequence of A.
            if (stack.isEmpty() || A[i] < A[stack.peek()]) {
                stack.push(i);
            }
        }

        int maxWidth = 0;
        // Iterate j from right to left
        for (int j = N - 1; j >= 0; j--) {
            // For the current A[j], we try to find the smallest possible i from the stack
            // such that A[i] <= A[j].
            // Since the stack stores indices with decreasing values,
            // the elements at the top of the stack are the smallest values (and smallest indices among those values).
            while (!stack.isEmpty() && A[stack.peek()] <= A[j]) {
                int i = stack.pop(); // Found a valid 'i' for the current 'j'
                maxWidth = Math.max(maxWidth, j - i);
            }
        }

        return maxWidth;
    }
}