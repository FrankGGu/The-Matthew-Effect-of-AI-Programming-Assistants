public class Solution {

import java.util.*;

public class Solution {
    public int[] findSpecialInteger(int[] nums) {
        int n = nums.length;
        if (n == 1) return new int[]{nums[0]};

        int count = 1;
        for (int i = 1; i < n; i++) {
            if (nums[i] == nums[i - 1]) {
                count++;
                if (count > n / 4) {
                    return new int[]{nums[i]};
                }
            } else {
                count = 1;
            }
        }

        return new int[]{-1};
    }
}
}