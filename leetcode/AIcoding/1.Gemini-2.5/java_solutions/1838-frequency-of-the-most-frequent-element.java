import java.util.Arrays;

class Solution {
    public int maxFrequency(int[] nums, int k) {
        Arrays.sort(nums);

        long currentSum = 0;
        int left = 0;
        int maxFrequency = 0;

        for (int right = 0; right < nums.length; right++) {
            currentSum += nums[right];

            // The condition for the window [left, right] to be valid is:
            // (nums[right] * (right - left + 1)) - currentSum <= k
            // If it's invalid, we shrink the window from the left.
            while ((long) nums[right] * (right - left + 1) - currentSum > k) {
                currentSum -= nums[left];
                left++;
            }

            // The current window [left, right] is valid.
            // Its length (frequency) is (right - left + 1).
            maxFrequency = Math.max(maxFrequency, right - left + 1);
        }

        return maxFrequency;
    }
}