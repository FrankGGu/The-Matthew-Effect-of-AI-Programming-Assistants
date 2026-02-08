import java.util.Arrays;

class Solution {
    public long maximizeActiveSection(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }

        int n = nums.length;
        long[] leftMax = new long[n];
        long[] rightMax = new long[n];

        // Calculate leftMax: maximum subarray sum ending at each index
        // This is a standard Kadane's algorithm pass.
        long currentMaxEndingHere = 0;
        long overallMax = Long.MIN_VALUE; // Stores the max sum without any flip

        for (int i = 0; i < n; i++) {
            currentMaxEndingHere = Math.max(nums[i], currentMaxEndingHere + nums[i]);
            leftMax[i] = currentMaxEndingHere;
            overallMax = Math.max(overallMax, currentMaxEndingHere);
        }

        // Calculate rightMax: maximum subarray sum starting at each index
        // This is Kadane's algorithm applied from right to left.
        currentMaxEndingHere = 0; // Reset for right-to-left pass
        for (int i = n - 1; i >= 0; i--) {
            currentMaxEndingHere = Math.max(nums[i], currentMaxEndingHere + nums[i]);
            rightMax[i] = currentMaxEndingHere;
        }

        // Now, iterate through each element and consider flipping its sign.
        // For each element nums[i] that is flipped to -nums[i],
        // the maximum subarray sum including this flipped element can be:
        // 1. Just the flipped element: -nums[i]
        // 2. Flipped element combined with a max subarray ending at i-1: leftMax[i-1] + (-nums[i])
        // 3. Flipped element combined with a max subarray starting at i+1: (-nums[i]) + rightMax[i+1]
        // 4. Flipped element combined with both: leftMax[i-1] + (-nums[i]) + rightMax[i+1]
        for (int i = 0; i < n; i++) {
            long sumWithFlippedElement = (long) -nums[i]; // Case 1

            // Case 2: Extend to the left
            if (i > 0) {
                sumWithFlippedElement = Math.max(sumWithFlippedElement, leftMax[i - 1] + (-nums[i]));
            }

            // Case 3: Extend to the right
            if (i < n - 1) {
                sumWithFlippedElement = Math.max(sumWithFlippedElement, (-nums[i]) + rightMax[i + 1]);
            }

            // Case 4: Extend both ways (only possible if i is not an endpoint)
            if (i > 0 && i < n - 1) {
                sumWithFlippedElement = Math.max(sumWithFlippedElement, leftMax[i - 1] + (-nums[i]) + rightMax[i + 1]);
            }

            overallMax = Math.max(overallMax, sumWithFlippedElement);
        }

        return overallMax;
    }
}