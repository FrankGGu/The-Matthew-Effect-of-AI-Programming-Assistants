import java.util.PriorityQueue;
import java.util.Arrays;

class Solution {
    public long minimumDifference(int[] nums) {
        int n = nums.length / 3;

        // leftMin[i] stores the minimum sum of n elements chosen from nums[0...i]
        // This is calculated using a max-priority queue to keep track of the n smallest elements
        long[] leftMin = new long[3 * n];
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a); // Max-heap to get smallest n elements
        long currentSum = 0;

        for (int i = 0; i < 3 * n; i++) {
            maxHeap.add(nums[i]);
            currentSum += nums[i];
            if (maxHeap.size() > n) {
                currentSum -= maxHeap.poll();
            }
            if (maxHeap.size() == n) {
                leftMin[i] = currentSum;
            } else {
                leftMin[i] = Long.MAX_VALUE; // Sentinel value if not enough elements yet
            }
        }

        // rightMax[i] stores the maximum sum of n elements chosen from nums[i...3*n-1]
        // This is calculated using a min-priority queue to keep track of the n largest elements
        long[] rightMax = new long[3 * n];
        PriorityQueue<Integer> minHeap = new PriorityQueue<>(); // Min-heap to get largest n elements
        currentSum = 0;

        for (int i = 3 * n - 1; i >= 0; i--) {
            minHeap.add(nums[i]);
            currentSum += nums[i];
            if (minHeap.size() > n) {
                currentSum -= minHeap.poll();
            }
            if (minHeap.size() == n) {
                rightMax[i] = currentSum;
            } else {
                rightMax[i] = Long.MIN_VALUE; // Sentinel value if not enough elements yet
            }
        }

        long minDifference = Long.MAX_VALUE;

        // Iterate through all possible split points 'i'
        // 'i' represents the last index of the first group of 'n' elements.
        // The first 'n' elements are chosen from nums[0...i].
        // The second 'n' elements are chosen from nums[i+1...3*n-1].
        // To minimize (sum of first n elements) - (sum of second n elements):
        // We need to minimize the first sum (leftMin[i]) and maximize the second sum (rightMax[i+1]).
        // The split point 'i' can range from n-1 (first n elements are nums[0...n-1])
        // to 2*n-1 (first n elements are chosen from nums[0...2*n-1], leaving nums[2*n...3*n-1] for the second group).
        for (int i = n - 1; i < 2 * n; i++) {
            // Ensure both leftMin[i] and rightMax[i+1] have valid sums
            if (leftMin[i] != Long.MAX_VALUE && rightMax[i + 1] != Long.MIN_VALUE) {
                minDifference = Math.min(minDifference, leftMin[i] - rightMax[i + 1]);
            }
        }

        return minDifference;
    }
}