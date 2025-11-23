public class Solution {

import java.util.*;

public class Solution {
    public int maxAfterMerge(int[] nums) {
        if (nums == null || nums.length == 0) return 0;

        int max = nums[0];
        for (int i = 1; i < nums.length; i++) {
            if (nums[i] > max) {
                max = nums[i];
            } else {
                nums[i] += nums[i - 1];
                if (nums[i] > max) {
                    max = nums[i];
                }
            }
        }
        return max;
    }
}
}