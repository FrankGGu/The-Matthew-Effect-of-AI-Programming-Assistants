import java.util.HashSet;
import java.util.Set;

class Solution {
    public long maximumSubarraySum(int[] nums) {
        Set<Integer> uniqueElements = new HashSet<>();
        for (int num : nums) {
            uniqueElements.add(num);
        }

        long overallMaxSum = Long.MIN_VALUE;

        for (int x : uniqueElements) {
            long currentMax = 0;
            long maxSumForX = Long.MIN_VALUE;
            boolean hasNonX = false;

            for (int num : nums) {
                if (num == x) {
                    // This element is removed, so it doesn't contribute to the sum
                    // and doesn't break the continuity of the subarray
                    // The Kadane's logic effectively skips it
                } else {
                    hasNonX = true;
                    currentMax += num;
                    maxSumForX = Math.max(maxSumForX, currentMax);
                    currentMax = Math.max(0, currentMax); // Reset currentMax if it becomes negative
                }
            }

            if (!hasNonX) { // All elements were 'x', resulting array is empty
                maxSumForX = 0;
            } else if (maxSumForX == Long.MIN_VALUE) {
                // This case handles scenarios where all non-x elements are negative.
                // The Kadane's algorithm with `currentMax = Math.max(0, currentMax)`
                // would return 0 if all sums are negative.
                // To get the largest single negative number, we need to re-evaluate without the reset to 0.
                // However, the current logic for `maxSumForX` correctly captures the largest single negative number
                // if all possible subarray sums are negative.
                // Example: nums = [-1, -2, -3], x = -5. Remaining [-1, -2, -3]. Max subarray sum is -1.
                // The loop:
                // num = -1: currentMax = -1, maxSumForX = -1, currentMax = 0
                // num = -2: currentMax = -2, maxSumForX = -1, currentMax = 0
                // num = -3: currentMax = -3, maxSumForX = -1, currentMax = 0
                // Result: maxSumForX = -1. This is correct.
            }
            overallMaxSum = Math.max(overallMaxSum, maxSumForX);
        }
        return overallMaxSum;
    }
}