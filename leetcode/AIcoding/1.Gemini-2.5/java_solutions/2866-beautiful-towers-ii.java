import java.util.List;
import java.util.Stack;

class Solution {
    public long maximumSumOfHeights(List<Integer> maxHeights) {
        int n = maxHeights.size();
        long[] leftSums = new long[n];
        long[] rightSums = new long[n];
        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < n; i++) {
            int currentHeight = maxHeights.get(i);
            while (!stack.isEmpty() && maxHeights.get(stack.peek()) >= currentHeight) {
                stack.pop();
            }

            long currentSegmentSum;
            int prevIdx = stack.isEmpty() ? -1 : stack.peek();

            currentSegmentSum = (long)currentHeight * (i - prevIdx);

            if (prevIdx != -1) {
                currentSegmentSum += leftSums[prevIdx];
            }
            leftSums[i] = currentSegmentSum;
            stack.push(i);
        }

        stack.clear();

        for (int i = n - 1; i >= 0; i--) {
            int currentHeight = maxHeights.get(i);
            while (!stack.isEmpty() && maxHeights.get(stack.peek()) >= currentHeight) {
                stack.pop();
            }

            long currentSegmentSum;
            int nextIdx = stack.isEmpty() ? n : stack.peek();

            currentSegmentSum = (long)currentHeight * (nextIdx - i);

            if (nextIdx != n) {
                currentSegmentSum += rightSums[nextIdx];
            }
            rightSums[i] = currentSegmentSum;
            stack.push(i);
        }

        long maxSum = 0;
        for (int i = 0; i < n; i++) {
            maxSum = Math.max(maxSum, leftSums[i] + rightSums[i] - maxHeights.get(i));
        }

        return maxSum;
    }
}