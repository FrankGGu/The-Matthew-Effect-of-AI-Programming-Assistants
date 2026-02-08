public class Solution {

import java.util.*;

public class Solution {
    public int[] applyOperations(int[] nums) {
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] != 0) {
                int j = i + 1;
                while (j < nums.length && nums[j] == 0) {
                    j++;
                }
                if (j < nums.length) {
                    nums[i] *= 2;
                    nums[j] = 0;
                }
            }
        }
        return nums;
    }
}
}