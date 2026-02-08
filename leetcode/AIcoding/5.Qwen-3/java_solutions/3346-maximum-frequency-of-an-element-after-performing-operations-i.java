public class Solution {

import java.util.*;

public class Solution {
    public int maxFrequency(List<Integer> nums, int k) {
        Collections.sort(nums);
        int left = 0;
        int maxFreq = 0;
        long total = 0;

        for (int right = 0; right < nums.size(); right++) {
            total += nums.get(right);

            while ((long) nums.get(right) * (right - left + 1) - total > k) {
                total -= nums.get(left);
                left++;
            }

            maxFreq = Math.max(maxFreq, right - left + 1);
        }

        return maxFreq;
    }
}
}