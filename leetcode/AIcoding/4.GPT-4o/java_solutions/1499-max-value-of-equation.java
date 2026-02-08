import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public int findMaxValueOfEquation(int[][] points, int k) {
        Deque<int[]> deque = new LinkedList<>();
        int maxVal = Integer.MIN_VALUE;

        for (int[] point : points) {
            while (!deque.isEmpty() && point[0] - deque.peekFirst()[0] > k) {
                deque.pollFirst();
            }
            if (!deque.isEmpty()) {
                maxVal = Math.max(maxVal, point[0] + point[1] + deque.peekFirst()[1] - deque.peekFirst()[0]);
            }
            while (!deque.isEmpty() && deque.peekLast()[1] - deque.peekLast()[0] <= point[1] - point[0]) {
                deque.pollLast();
            }
            deque.offerLast(point);
        }
        return maxVal;
    }
}