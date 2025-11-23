public class Solution {

import java.util.*;

public class Solution {
    public int closestToK(int[] nums, int k) {
        int n = nums.length;
        int minDiff = Integer.MAX_VALUE;
        int result = 0;

        for (int i = 0; i < n; i++) {
            int currentOr = 0;
            for (int j = i; j < n; j++) {
                currentOr |= nums[j];
                int diff = Math.abs(currentOr - k);
                if (diff < minDiff) {
                    minDiff = diff;
                    result = currentOr;
                } else if (diff == minDiff && currentOr < result) {
                    result = currentOr;
                }
            }
        }

        return result;
    }
}
}