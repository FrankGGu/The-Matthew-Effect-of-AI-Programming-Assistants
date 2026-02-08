public class Solution {

import java.util.*;

public class Solution {
    public boolean canWin(int[] nums) {
        int n = nums.length;
        Set<Integer> seen = new HashSet<>();
        for (int i = 0; i < n; i++) {
            if (seen.contains(nums[i])) {
                return true;
            }
            seen.add(nums[i]);
        }
        return false;
    }
}
}