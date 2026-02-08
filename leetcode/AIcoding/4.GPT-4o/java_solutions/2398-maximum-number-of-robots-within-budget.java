import java.util.*;

class Solution {
    public int maximumRobots(int[] chargeTimes, int budget) {
        int n = chargeTimes.length;
        int left = 0, right = 0, maxRobots = 0;
        Deque<Integer> deque = new ArrayDeque<>();
        long totalCost = 0;

        while (right < n) {
            totalCost += chargeTimes[right];
            while (!deque.isEmpty() && chargeTimes[deque.peekLast()] < chargeTimes[right]) {
                deque.pollLast();
            }
            deque.addLast(right);

            while (!deque.isEmpty() && totalCost + (long) (deque.size() - 1) * chargeTimes[deque.peekFirst()] > budget) {
                totalCost -= chargeTimes[left];
                if (left == deque.peekFirst()) {
                    deque.pollFirst();
                }
                left++;
            }

            maxRobots = Math.max(maxRobots, right - left + 1);
            right++;
        }

        return maxRobots;
    }
}