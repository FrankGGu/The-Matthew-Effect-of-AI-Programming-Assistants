class Solution {
    public long maximumSumOfHeights(List<Integer> maxHeights) {
        int n = maxHeights.size();
        long[] left = new long[n];
        long[] right = new long[n];
        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && maxHeights.get(stack.peek()) > maxHeights.get(i)) {
                stack.pop();
            }
            if (stack.isEmpty()) {
                left[i] = (long) (i + 1) * maxHeights.get(i);
            } else {
                int prev = stack.peek();
                left[i] = left[prev] + (long) (i - prev) * maxHeights.get(i);
            }
            stack.push(i);
        }

        stack.clear();
        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && maxHeights.get(stack.peek()) > maxHeights.get(i)) {
                stack.pop();
            }
            if (stack.isEmpty()) {
                right[i] = (long) (n - i) * maxHeights.get(i);
            } else {
                int prev = stack.peek();
                right[i] = right[prev] + (long) (prev - i) * maxHeights.get(i);
            }
            stack.push(i);
        }

        long maxSum = 0;
        for (int i = 0; i < n; i++) {
            maxSum = Math.max(maxSum, left[i] + right[i] - maxHeights.get(i));
        }
        return maxSum;
    }
}