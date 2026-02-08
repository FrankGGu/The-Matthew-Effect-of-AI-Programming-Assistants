class Solution {
    public int[] maxAltitude(int[] heights, int k) {
        if (heights == null || heights.length == 0 || k <= 0) {
            return new int[0];
        }
        int n = heights.length;
        int[] result = new int[n - k + 1];
        Deque<Integer> deque = new ArrayDeque<>();
        for (int i = 0; i < n; i++) {
            while (!deque.isEmpty() && deque.peekFirst() < i - k + 1) {
                deque.pollFirst();
            }
            while (!deque.isEmpty() && heights[deque.peekLast()] < heights[i]) {
                deque.pollLast();
            }
            deque.offerLast(i);
            if (i >= k - 1) {
                result[i - k + 1] = heights[deque.peekFirst()];
            }
        }
        return result;
    }
}