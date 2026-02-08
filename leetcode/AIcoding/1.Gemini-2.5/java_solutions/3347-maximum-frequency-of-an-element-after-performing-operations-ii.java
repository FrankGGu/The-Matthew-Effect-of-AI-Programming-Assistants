import java.util.Arrays;

class Solution {
    public int maxFrequency(int[] nums, int k) {
        Arrays.sort(nums);

        long currentSum = 0;
        int left = 0;
        int maxFreq = 0;

        for (int right = 0; right < nums.length; right++) {
            currentSum += nums[right];

            // Check if the current window [left, right] is valid
            // To make all elements in the window equal to nums[right],
            // the total operations needed would be:
            // (nums[right] - nums[left]) + (nums[right] - nums[left+1]) + ... + (nums[right] - nums[right-1])
            // This simplifies to: (window_size * nums[right]) - sum_of_elements_in_window
            // Where window_size = (right - left + 1)
            while ((long) (right - left + 1) * nums[right] - currentSum > k) {
                currentSum -= nums[left];
                left++;
            }

            // The current window [left, right] is valid, update maxFreq
            maxFreq = Math.max(maxFreq, right - left + 1);
        }

        return maxFreq;
    }
}