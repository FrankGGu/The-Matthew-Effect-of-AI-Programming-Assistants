import java.util.List;
import java.util.Stack;

class Solution {
    public long maximumSumOfHeights(List<Integer> maxHeights) {
        int n = maxHeights.size();
        long[] left = new long[n];
        long[] right = new long[n];

        Stack<Integer> st = new Stack<>();
        long currentSum = 0;

        for (int i = 0; i < n; i++) {
            int h = maxHeights.get(i);
            while (!st.isEmpty() && maxHeights.get(st.peek()) >= h) {
                int j = st.pop();
                int prevIdx = st.isEmpty() ? -1 : st.peek();
                currentSum -= (long)maxHeights.get(j) * (j - prevIdx);
            }
            int prevIdx = st.isEmpty() ? -1 : st.peek();
            currentSum += (long)h * (i - prevIdx);
            st.push(i);
            left[i] = currentSum;
        }

        st.clear();
        currentSum = 0;

        for (int i = n - 1; i >= 0; i--) {
            int h = maxHeights.get(i);
            while (!st.isEmpty() && maxHeights.get(st.peek()) >= h) {
                int j = st.pop();
                int nextIdx = st.isEmpty() ? n : st.peek();
                currentSum -= (long)maxHeights.get(j) * (nextIdx - j);
            }
            int nextIdx = st.isEmpty() ? n : st.peek();
            currentSum += (long)h * (nextIdx - i);
            st.push(i);
            right[i] = currentSum;
        }

        long maxSum = 0;
        for (int i = 0; i < n; i++) {
            maxSum = Math.max(maxSum, left[i] + right[i] - maxHeights.get(i));
        }

        return maxSum;
    }
}