public class Solution {

import java.util.*;

public class Solution {
    public int minIncrements(int[] nums, int target) {
        Arrays.sort(nums);
        int res = 0;
        for (int i = 0; i < nums.length && target > 0; i++) {
            if (nums[i] >= target) {
                break;
            }
            res += target - nums[i];
            target = 0;
        }
        return res;
    }
}
}