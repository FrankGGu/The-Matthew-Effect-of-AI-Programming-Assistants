import java.util.List;
import java.util.Stack;

class Solution {
    public long maximumSumOfHeights(List<Integer> maxHeights) {
        int n = maxHeights.size();
        long[] leftSums = new long[n];
        long[] rightSums = new long[n];

        Stack<Integer> stack = new Stack<>();
        long currentSum = 0;

        for (int i = 0; i < n; i++) {
            int h_i = maxHeights.get(i);
            while (!stack.isEmpty() && maxHeights.get(stack.peek()) > h_i) {
                int j = stack.pop();
                int prevIdx = stack.isEmpty() ? -1 : stack.peek();
                currentSum -= (long)maxHeights.get(j) * (j - prevIdx);
            }
            int prevIdx = stack.isEmpty() ? -1 : stack.peek();
            currentSum += (long)h_i * (i - prevIdx);
            stack.push(i);
            leftSums[i] = currentSum;
        }

        stack.clear();
        currentSum = 0;

        for (int i = n - 1; i >= 0; i--) {
            int h_i = maxHeights.get(i);
            while (!stack.isEmpty() && maxHeights.get(stack.peek()) > h_i) {
                int j = stack.pop();
                int prevIdx = stack.isEmpty() ? n : stack.peek();
                currentSum -= (long)maxHeights.get(j) * (prevIdx - j);
            }
            int prevIdx = stack.isEmpty() ? n : stack.peek();
            currentSum += (long)h_i * (prevIdx - i);
            stack.push(i);
            rightSums[i] = currentSum;
        }

        long maxTotalSum = 0;
        for (int i = 0; i < n; i++) {
            maxTotalSum = Math.max(maxTotalSum, leftSums[i] + rightSums[i] - maxHeights.get(i));
        }

        return maxTotalSum;
    }
}