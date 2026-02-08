class Solution {
    public int longestNiceSubarray(int[] nums) {
        int left = 0;
        int currentOR = 0;
        int maxLength = 0;

        for (int right = 0; right < nums.length; right++) {
            // While the current number nums[right] conflicts with any number in the window [left, right-1]
            // (i.e., they share at least one set bit), shrink the window from the left.
            while ((currentOR & nums[right]) != 0) {
                // Remove nums[left] from the currentOR.
                // This works because all numbers in a nice subarray are pairwise bitwise disjoint.
                // So, XORing nums[left] effectively removes its unique bit contributions.
                currentOR ^= nums[left];
                left++;
            }

            // Add nums[right] to the currentOR.
            currentOR |= nums[right];

            // Update the maximum length found so far.
            maxLength = Math.max(maxLength, right - left + 1);
        }

        return maxLength;
    }
}