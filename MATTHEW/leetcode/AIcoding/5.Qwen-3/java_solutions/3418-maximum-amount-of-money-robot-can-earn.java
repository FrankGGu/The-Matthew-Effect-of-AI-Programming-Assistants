public class Solution {

import java.util.*;

public class Solution {
    public int maxMoney(int[] nums) {
        if (nums == null || nums.length == 0) return 0;
        if (nums.length == 1) return nums[0];
        if (nums.length == 2) return Math.max(nums[0], nums[1]);

        int prevPrev = nums[0];
        int prev = Math.max(nums[0], nums[1]);

        for (int i = 2; i < nums.length; i++) {
            int current = Math.max(prev, prevPrev + nums[i]);
            prevPrev = prev;
            prev = current;
        }

        return prev;
    }
}
}