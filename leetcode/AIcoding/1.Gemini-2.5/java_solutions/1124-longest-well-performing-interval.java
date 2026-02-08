import java.util.Stack;

class Solution {
    public int longestWellPerformingInterval(int[] hours) {
        int n = hours.length;
        int[] prefixSums = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSums[i + 1] = prefixSums[i] + (hours[i] > 8 ? 1 : -1);
        }

        Stack<Integer> stack = new Stack<>();
        for (int i = 0; i <= n; i++) {
            if (stack.isEmpty() || prefixSums[i] < prefixSums[stack.peek()]) {
                stack.push(i);
            }
        }

        int maxLength = 0;
        for (int j = n; j >= 0; j--) {
            while (!stack.isEmpty() && prefixSums[j] > prefixSums[stack.peek()]) {
                maxLength = Math.max(maxLength, j - stack.pop());
            }
        }
        return maxLength;
    }
}