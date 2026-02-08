import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public int shortestSubarray(int[] nums, int k) {
        int n = nums.length;
        int[] preSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            preSum[i + 1] = preSum[i] + nums[i];
        }

        int minLen = n + 1;
        Deque<Integer> deque = new LinkedList<>();
        for (int i = 0; i <= n; i++) {
            while (!deque.isEmpty() && preSum[i] - preSum[deque.getFirst()] >= k) {
                minLen = Math.min(minLen, i - deque.pollFirst());
            }
            while (!deque.isEmpty() && preSum[i] <= preSum[deque.getLast()]) {
                deque.pollLast();
            }
            deque.offerLast(i);
        }

        return minLen > n ? -1 : minLen;
    }
}