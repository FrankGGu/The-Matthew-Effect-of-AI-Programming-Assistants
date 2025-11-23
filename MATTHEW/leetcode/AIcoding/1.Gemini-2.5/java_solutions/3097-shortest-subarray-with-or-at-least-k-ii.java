class Solution {
    public int shortestSubarrayWithORAtLeastK(int[] nums, int k) {
        int n = nums.length;
        int minLen = Integer.MAX_VALUE;

        // bitCounts[j] stores the count of numbers in the current window [left, right]
        // that have the j-th bit set.
        // Max value of nums[i] is 10^9, which requires up to bit 29.
        // So, we need 30 bits (from 0 to 29).
        int[] bitCounts = new int[30]; 

        int currentOR = 0;
        int left = 0;

        for (int right = 0; right < n; right++) {
            // Add nums[right] to the window
            for (int j = 0; j < 30; j++) {
                if (((nums[right] >> j) & 1) == 1) {
                    bitCounts[j]++;
                    // If this is the first time this bit is set in the window,
                    // then it contributes to currentOR.
                    if (bitCounts[j] == 1) {
                        currentOR |= (1 << j);
                    }
                }
            }

            // While currentOR is at least k, try to shrink the window from the left
            while (currentOR >= k) {
                minLen = Math.min(minLen, right - left + 1);

                // Remove nums[left] from the window
                for (int j = 0; j < 30; j++) {
                    if (((nums[left] >> j) & 1) == 1) {
                        bitCounts[j]--;
                        // If this bit is no longer set by any number in the window,
                        // then it no longer contributes to currentOR.
                        if (bitCounts[j] == 0) {
                            currentOR &= ~(1 << j);
                        }
                    }
                }
                left++;
            }
        }

        return (minLen == Integer.MAX_VALUE) ? -1 : minLen;
    }
}