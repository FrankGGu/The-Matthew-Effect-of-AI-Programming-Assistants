class Solution {
    public long countAlternatingSubarrays(int[] nums) {
        long totalCount = 0;
        int currentAlternatingLength = 0;

        // The problem constraints state 1 <= nums.length <= 10^5,
        // so nums is never empty.
        // For the first element (nums[0]), it always forms an alternating subarray of length 1.
        currentAlternatingLength = 1;
        totalCount = 1;

        for (int i = 1; i < nums.length; i++) {
            if (nums[i] != nums[i - 1]) {
                // If the current element is different from the previous,
                // we can extend the current alternating subarray.
                currentAlternatingLength++;
            } else {
                // If the current element is the same as the previous,
                // the alternating sequence is broken. Start a new one with the current element.
                currentAlternatingLength = 1;
            }
            // Add all alternating subarrays ending at the current position 'i'.
            // These are of lengths 1, 2, ..., currentAlternatingLength.
            // The count of such subarrays is simply currentAlternatingLength.
            totalCount += currentAlternatingLength;
        }

        return totalCount;
    }
}