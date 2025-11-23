public class Solution {

import java.util.*;

public class Solution {
    public int maxFrequencyScore(int[] nums, int k) {
        Arrays.sort(nums);
        int left = 0;
        long total = 0;
        int maxFreq = 0;
        for (int right = 0; right < nums.length; right++) {
            total += nums[right];
            while (total > (long) k * (right - left + 1)) {
                total -= nums[left];
                left++;
            }
            maxFreq = Math.max(maxFreq, right - left + 1);
        }
        return maxFreq;
    }
}
}