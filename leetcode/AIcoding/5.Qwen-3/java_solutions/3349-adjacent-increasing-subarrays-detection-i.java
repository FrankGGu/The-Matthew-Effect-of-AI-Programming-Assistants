public class Solution {

import java.util.*;

public class Solution {
    public boolean isAdjacentIncreasing(int[] nums) {
        if (nums.length < 2) return false;

        int n = nums.length;
        for (int i = 0; i < n - 1; i++) {
            if (nums[i] >= nums[i + 1]) {
                return false;
            }
        }
        return true;
    }
}
}