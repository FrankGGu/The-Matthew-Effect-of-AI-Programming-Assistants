import java.util.Stack;

class Solution {
    public int sumSubarrayMins(int[] arr) {
        int n = arr.length;
        long MOD = 1_000_000_007;

        int[] ple = new int[n]; // Previous Less Element index
        int[] nle = new int[n]; // Next Less or Equal Element index

        Stack<Integer> stack = new Stack<>();

        // Calculate ple (Previous Strictly Less Element)
        // For each arr[i], find the index of the first element to its left that is strictly less than arr[i].
        // If no such element, ple[i] = -1.
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && arr[stack.peek()] >= arr[i]) {
                stack.pop();
            }
            ple[i] = stack.isEmpty() ? -1 : stack.peek();
            stack.push(i);
        }

        stack.clear();

        // Calculate nle (Next Less or Equal Element)
        // For each arr[i], find the index of the first element to its right that is less than or equal to arr[i].
        // If no such element, nle[i] = n.
        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && arr[stack.peek()] > arr[i]) {
                stack.pop();
            }
            nle[i] = stack.isEmpty() ? n : stack.peek();
            stack.push(i);
        }

        long totalSum = 0;
        for (int i = 0; i < n; i++) {
            long leftCount = i - ple[i];
            long rightCount = nle[i] - i;

            long contribution = (arr[i] * leftCount % MOD * rightCount % MOD) % MOD;
            totalSum = (totalSum + contribution) % MOD;
        }

        return (int) totalSum;
    }
}