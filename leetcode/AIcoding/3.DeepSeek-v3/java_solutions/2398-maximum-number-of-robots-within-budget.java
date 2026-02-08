class Solution {
    public int maximumRobots(int[] chargeTimes, int[] runningCosts, long budget) {
        int n = chargeTimes.length;
        int left = 0;
        int maxRobots = 0;
        long currentSum = 0;
        Deque<Integer> deque = new ArrayDeque<>();

        for (int right = 0; right < n; right++) {
            currentSum += runningCosts[right];

            while (!deque.isEmpty() && chargeTimes[deque.peekLast()] <= chargeTimes[right]) {
                deque.pollLast();
            }
            deque.offerLast(right);

            while (left <= right && chargeTimes[deque.peekFirst()] + (right - left + 1) * currentSum > budget) {
                if (deque.peekFirst() == left) {
                    deque.pollFirst();
                }
                currentSum -= runningCosts[left];
                left++;
            }

            maxRobots = Math.max(maxRobots, right - left + 1);
        }

        return maxRobots;
    }
}