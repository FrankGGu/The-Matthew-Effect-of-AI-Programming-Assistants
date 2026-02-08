public class Solution {

import java.util.*;

public class Solution {
    public int partitionDisjoint(int[] nums) {
        int n = nums.length;
        int[] leftMax = new int[n];
        leftMax[0] = nums[0];
        for (int i = 1; i < n; i++) {
            leftMax[i] = Math.max(leftMax[i - 1], nums[i]);
        }

        int rightMin = nums[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            if (leftMax[i] <= rightMin) {
                return i + 1;
            }
            rightMin = Math.min(rightMin, nums[i]);
        }

        return 0;
    }
}
}