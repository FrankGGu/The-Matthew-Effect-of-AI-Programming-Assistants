import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public int maximumRobots(int[] chargeTimes, int[] runningCosts, long budget) {
        int n = chargeTimes.length;
        int left = 0, right = 0;
        long currentCost = 0;
        Deque<Integer> deque = new ArrayDeque<>();
        int maxRobots = 0;

        while (right < n) {
            while (!deque.isEmpty() && chargeTimes[deque.peekLast()] <= chargeTimes[right]) {
                deque.pollLast();
            }
            deque.offerLast(right);

            currentCost += runningCosts[right];

            while (!deque.isEmpty() && (chargeTimes[deque.peekFirst()] + (right - left + 1) * currentCost) > budget) {
                currentCost -= runningCosts[left];
                if (deque.peekFirst() == left) {
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