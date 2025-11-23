public class Solution {

import java.util.*;

public class Solution {
    public int maxSubarrays(int[] nums) {
        int n = nums.length;
        int result = 0;
        int min = Integer.MAX_VALUE;
        int max = Integer.MIN_VALUE;
        int currentMin = Integer.MAX_VALUE;
        int currentMax = Integer.MIN_VALUE;
        int count = 0;

        for (int i = 0; i < n; i++) {
            currentMin = Math.min(currentMin, nums[i]);
            currentMax = Math.max(currentMax, nums[i]);
            if (currentMin == nums[i] || currentMax == nums[i]) {
                count++;
                currentMin = Integer.MAX_VALUE;
                currentMax = Integer.MIN_VALUE;
            }
        }

        return count == 0 ? 1 : count;
    }
}
}