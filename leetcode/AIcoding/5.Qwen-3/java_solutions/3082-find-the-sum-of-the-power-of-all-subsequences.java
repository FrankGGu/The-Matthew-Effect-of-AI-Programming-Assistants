public class Solution {

import java.util.*;

public class Solution {
    public int sumOfPowers(int[] nums) {
        int n = nums.length;
        int result = 0;
        for (int mask = 0; mask < (1 << n); mask++) {
            int min = Integer.MAX_VALUE;
            int max = Integer.MIN_VALUE;
            boolean hasElements = false;
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) != 0) {
                    min = Math.min(min, nums[i]);
                    max = Math.max(max, nums[i]);
                    hasElements = true;
                }
            }
            if (hasElements) {
                result += (max - min);
            }
        }
        return result;
    }
}
}