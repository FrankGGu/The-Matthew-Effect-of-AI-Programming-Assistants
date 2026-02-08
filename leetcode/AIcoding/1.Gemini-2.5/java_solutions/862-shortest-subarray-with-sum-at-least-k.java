import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public int shortestSubarray(int[] nums, int k) {
        int n = nums.length;
        long[] prefixSums = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSums[i + 1] = prefixSums[i] + nums[i];
        }

        int minLength = n + 1;
        Deque<Integer> deque = new ArrayDeque<>(); // Stores indices of prefixSums

        for (int i = 0; i <= n; i++) {
            // Condition 1: prefixSums[i] - prefixSums[deque.peekFirst()] >= k
            // We found a subarray with sum at least k.
            // Since we want the shortest, we can remove the front element
            // because any further subarray starting at deque.peekFirst()
            // will be longer.
            while (!deque.isEmpty() && prefixSums[i] - prefixSums[deque.peekFirst()] >= k) {
                minLength = Math.min(minLength, i - deque.pollFirst());
            }

            // Condition 2: prefixSums[i] <= prefixSums[deque.peekLast()]
            // If the current prefix sum is less than or equal to the last one in deque,
            // the last one is not useful.
            // Why? If prefixSums[i] <= prefixSums[j] where i > j (j is deque.peekLast()),
            // then for any future index 'x' (x > i),
            // prefixSums[x] - prefixSums[i] will be greater than or equal to prefixSums[x] - prefixSums[j].
            // Also, 'i' is a larger index than 'j', so 'x - i' is a shorter length than 'x - j'.
            // Thus, 'i' is a better candidate for the start of a subarray than 'j'.
            while (!deque.isEmpty() && prefixSums[i] <= prefixSums[deque.peekLast()]) {
                deque.pollLast();
            }

            deque.offerLast(i);
        }

        return minLength == n + 1 ? -1 : minLength;
    }
}