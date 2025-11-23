import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public int maxJump(int[] stones, int k) {
        int n = stones.length;
        int[] dp = new int[n];
        dp[0] = stones[0];
        Deque<Integer> deque = new LinkedList<>();
        deque.offer(0);

        for (int i = 1; i < n; i++) {
            while (!deque.isEmpty() && deque.peekFirst() < i - k) {
                deque.pollFirst();
            }
            dp[i] = stones[i] + (deque.isEmpty() ? 0 : dp[deque.peekFirst()]);
            while (!deque.isEmpty() && dp[deque.peekLast()] <= dp[i]) {
                deque.pollLast();
            }
            deque.offerLast(i);
        }

        return dp[n - 1];
    }
}