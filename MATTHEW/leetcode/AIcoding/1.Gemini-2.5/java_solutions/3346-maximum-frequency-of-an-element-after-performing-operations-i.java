import java.util.Arrays;

class Solution {
    public int maxFrequency(int[] nums, int k) {
        Arrays.sort(nums);

        long currentSum = 0;
        int left = 0;
        int maxFreq = 0;

        for (int right = 0; right < nums.length; right++) {
            currentSum += nums[right];

            // The cost to make all elements in the window [left, right] equal to nums[right]
            // is (count * nums[right]) - currentSum.
            // count = (right - left + 1)
            while ((long) (right - left + 1) * nums[right] - currentSum > k) {
                currentSum -= nums[left];
                left++;
            }
            maxFreq = Math.max(maxFreq, right - left + 1);
        }

        return maxFreq;
    }
}