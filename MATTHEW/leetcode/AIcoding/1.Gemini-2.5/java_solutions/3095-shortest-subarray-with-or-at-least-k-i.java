import java.util.Arrays;

class Solution {
    public int shortestSubarrayWithORAtLeastK(int[] nums, int k) {
        int n = nums.length;
        int minLen = Integer.MAX_VALUE;
        int left = 0;
        int[] bitCounts = new int[31]; // Stores frequency of each bit (0 to 30) in the current window
        int currentOR = 0;

        for (int right = 0; right < n; right++) {
            int num = nums[right];

            // Add nums[right] to the window and update bitCounts
            for (int j = 0; j < 31; j++) {
                if (((num >> j) & 1) == 1) {
                    bitCounts[j]++;
                }
            }

            // Recalculate currentOR based on the updated bitCounts
            // This is necessary because the OR sum doesn't simply decrease when elements are removed.
            // It must be reconstructed from the bits that are still present.
            currentOR = 0;
            for (int j = 0; j < 31; j++) {
                if (bitCounts[j] > 0) {
                    currentOR |= (1 << j);
                }
            }

            // While the current window's OR sum is at least K,
            // try to shrink the window from the left to find the shortest possible subarray.
            while (currentOR >= k && left <= right) {
                minLen = Math.min(minLen, right - left + 1);

                int leftNum = nums[left];
                // Remove nums[left] from the window and update bitCounts
                for (int j = 0; j < 31; j++) {
                    if (((leftNum >> j) & 1) == 1) {
                        bitCounts[j]--;
                    }
                }

                // Recalculate currentOR after removing nums[left]
                currentOR = 0;
                for (int j = 0; j < 31; j++) {
                    if (bitCounts[j] > 0) {
                        currentOR |= (1 << j);
                    }
                }
                left++;
            }
        }

        return minLen == Integer.MAX_VALUE ? -1 : minLen;
    }
}