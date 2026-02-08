class Solution {
    public long maximumSumOfHeights(List<Integer> maxHeights) {
        int n = maxHeights.size();
        long[] prefixSum = new long[n];
        long[] suffixSum = new long[n];
        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && maxHeights.get(stack.peek()) > maxHeights.get(i)) {
                stack.pop();
            }
            if (stack.isEmpty()) {
                prefixSum[i] = (long) (i + 1) * maxHeights.get(i);
            } else {
                prefixSum[i] = prefixSum[stack.peek()] + (long) (i - stack.peek()) * maxHeights.get(i);
            }
            stack.push(i);
        }

        stack.clear();

        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && maxHeights.get(stack.peek()) > maxHeights.get(i)) {
                stack.pop();
            }
            if (stack.isEmpty()) {
                suffixSum[i] = (long) (n - i) * maxHeights.get(i);
            } else {
                suffixSum[i] = suffixSum[stack.peek()] + (long) (stack.peek() - i) * maxHeights.get(i);
            }
            stack.push(i);
        }

        long maxSum = 0;
        for (int i = 0; i < n; i++) {
            maxSum = Math.max(maxSum, prefixSum[i] + suffixSum[i] - maxHeights.get(i));
        }

        return maxSum;
    }
}