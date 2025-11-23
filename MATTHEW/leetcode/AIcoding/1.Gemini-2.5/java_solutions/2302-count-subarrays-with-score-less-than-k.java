class Solution {
    public long countSubarrays(int[] nums, long k) {
        long count = 0;
        long currentSum = 0;
        int left = 0;

        for (int right = 0; right < nums.length; right++) {
            currentSum += nums[right];
            long currentLength = right - left + 1;

            // Shrink the window from the left if the score (currentSum * currentLength) is greater than or equal to k
            while (currentSum * currentLength >= k) {
                currentSum -= nums[left];
                left++;
                currentLength = right - left + 1; // Update length after shrinking
            }

            // All subarrays ending at 'right' and starting from 'left' up to 'right' are valid.
            // There are (right - left + 1) such subarrays.
            // If left > right, currentLength will be 0 or negative, which means 0 valid subarrays.
            // Adding currentLength directly handles this as currentLength would be 0 or less.
            // Since nums[i] >= 1 and k >= 1, currentLength will never be negative in a valid window.
            // It can be 0 if the window shrinks completely.
            count += currentLength;
        }

        return count;
    }
}