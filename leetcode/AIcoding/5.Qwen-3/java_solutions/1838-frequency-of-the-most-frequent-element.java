public class Solution {

import java.util.Arrays;

public class Solution {
    public int maxFrequency(int[] nums, int k) {
        Arrays.sort(nums);
        int left = 0;
        int maxFreq = 0;
        long total = 0;

        for (int right = 0; right < nums.length; right++) {
            total += nums[right];

            while (total - nums[right] * (right - left + 1) > k) {
                total -= nums[left];
                left++;
            }

            maxFreq = Math.max(maxFreq, right - left + 1);
        }

        return maxFreq;
    }
}
}