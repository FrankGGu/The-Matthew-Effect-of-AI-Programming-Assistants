class Solution {
    public int longestEvenOddSubarray(int[] nums, int threshold) {
        int maxLen = 0;
        int currentLen = 0;

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] > threshold) {
                // This element violates the threshold condition, it cannot be part of any valid subarray.
                // Reset currentLen and move to the next element.
                currentLen = 0;
                continue;
            }

            // At this point, nums[i] <= threshold.
            if (currentLen == 0) {
                // Not currently in a valid subarray, try to start one.
                // The first element of a valid subarray must be even.
                if (nums[i] % 2 == 0) {
                    currentLen = 1;
                }
            } else {
                // Currently in a valid subarray, try to extend it.
                // We need to check if the parity alternates.
                if (nums[i] % 2 != nums[i - 1] % 2) {
                    currentLen++;
                } else {
                    // Parity condition violated, the current valid subarray ends.
                    // Now, check if the current element nums[i] can start a *new* valid subarray.
                    currentLen = 0; // Reset current length
                    if (nums[i] % 2 == 0) { // A new subarray can start if nums[i] is even.
                        currentLen = 1;
                    }
                }
            }
            maxLen = Math.max(maxLen, currentLen);
        }

        return maxLen;
    }
}