import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public long[] maximumAndMinimumSum(int[] nums, int k) {
        int n = nums.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        long maxSum = Long.MIN_VALUE;
        long minSum = Long.MAX_VALUE;

        Deque<Integer> minDeque = new ArrayDeque<>(); // Stores indices j for prefixSum[j] in increasing order
        Deque<Integer> maxDeque = new ArrayDeque<>(); // Stores indices j for prefixSum[j] in decreasing order

        // Initialize deques with index 0 (representing prefixSum[0] = 0)
        minDeque.addLast(0);
        maxDeque.addLast(0);

        for (int i = 0; i < n; i++) {
            int currPrefixSumIdx = i + 1; // Current index for prefixSum[currPrefixSumIdx]

            // --- Calculate Maximum Sum ---
            // The subarray ends at index 'i' (nums[i]). Its sum is prefixSum[currPrefixSumIdx] - prefixSum[j].
            // The length of the subarray is (i - j + 1).
            // Constraint: 1 <= (i - j + 1) <= k
            // This implies: j >= i - k + 1. Since j is also >= 0, j >= max(0, i - k + 1).
            // So, j must be >= currPrefixSumIdx - k.

            // Remove indices from the front of minDeque that are out of the valid window for 'j'
            while (!minDeque.isEmpty() && minDeque.peekFirst() < currPrefixSumIdx - k) {
                minDeque.removeFirst();
            }
            // The minimum prefixSum[j] in the current window is at the front of minDeque
            maxSum = Math.max(maxSum, prefixSum[currPrefixSumIdx] - prefixSum[minDeque.peekFirst()]);
            // Remove indices from the back of minDeque whose prefixSum values are >= prefixSum[currPrefixSumIdx]
            // This maintains the property that prefixSum values for indices in minDeque are increasing
            while (!minDeque.isEmpty() && prefixSum[minDeque.peekLast()] >= prefixSum[currPrefixSumIdx]) {
                minDeque.removeLast();
            }
            // Add current prefix sum index to minDeque
            minDeque.addLast(currPrefixSumIdx);

            // --- Calculate Minimum Sum ---
            // Similarly, for minimum sum, we need to maximize prefixSum[j] in the window.

            // Remove indices from the front of maxDeque that are out of the valid window for 'j'
            while (!maxDeque.isEmpty() && maxDeque.peekFirst() < currPrefixSumIdx - k) {
                maxDeque.removeFirst();
            }
            // The maximum prefixSum[j] in the current window is at the front of maxDeque
            minSum = Math.min(minSum, prefixSum[currPrefixSumIdx] - prefixSum[maxDeque.peekFirst()]);
            // Remove indices from the back of maxDeque whose prefixSum values are <= prefixSum[currPrefixSumIdx]
            // This maintains the property that prefixSum values for indices in maxDeque are decreasing
            while (!maxDeque.isEmpty() && prefixSum[maxDeque.peekLast()] <= prefixSum[currPrefixSumIdx]) {
                maxDeque.removeLast();
            }
            // Add current prefix sum index to maxDeque
            maxDeque.addLast(currPrefixSumIdx);
        }

        return new long[]{maxSum, minSum};
    }
}