public class Solution {

import java.util.*;

public class Solution {
    public int maxFrequency(List<Integer> nums, int k) {
        int n = nums.size();
        int left = 0;
        int maxFreq = 0;
        int total = 0;

        for (int right = 0; right < n; right++) {
            total += nums.get(right);

            while (total > k + nums.get(right) * (right - left + 1)) {
                total -= nums.get(left);
                left++;
            }

            maxFreq = Math.max(maxFreq, right - left + 1);
        }

        return maxFreq;
    }
}
}