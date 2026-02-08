import java.util.*;

public class Solution {
    public int shortestSubarray(int[] A, int K) {
        int N = A.length;
        long[] prefixSum = new long[N + 1];
        for (int i = 0; i < N; i++) {
            prefixSum[i + 1] = prefixSum[i] + A[i];
        }

        Deque<Integer> deque = new ArrayDeque<>();
        int minLength = Integer.MAX_VALUE;

        for (int i = 0; i <= N; i++) {
            while (!deque.isEmpty() && prefixSum[i] - prefixSum[deque.getFirst()] >= K) {
                minLength = Math.min(minLength, i - deque.pollFirst());
            }
            while (!deque.isEmpty() && prefixSum[i] <= prefixSum[deque.getLast()]) {
                deque.pollLast();
            }
            deque.addLast(i);
        }

        return minLength == Integer.MAX_VALUE ? -1 : minLength;
    }
}