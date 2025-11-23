public class Solution {

import java.util.*;

public class Solution {
    public int maxAdjacentDifference(int[] nums) {
        int n = nums.length;
        if (n < 2) return 0;

        int maxDiff = 0;
        for (int i = 0; i < n - 1; i++) {
            maxDiff = Math.max(maxDiff, Math.abs(nums[i] - nums[i + 1]));
        }
        maxDiff = Math.max(maxDiff, Math.abs(nums[n - 1] - nums[0]));

        return maxDiff;
    }
}
}