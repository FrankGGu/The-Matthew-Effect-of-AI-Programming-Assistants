public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums) {
        int n = nums.length;
        int operations = 0;
        int flip = 0;

        for (int i = 0; i < n; i++) {
            if (i >= 2 && nums[i - 2] == 1) {
                flip ^= 1;
            }
            if (nums[i] == flip) {
                operations++;
                flip ^= 1;
            }
        }

        return operations;
    }
}
}