public class Solution {

import java.util.*;

public class Solution {
    public int triangularSum(int[] nums) {
        int n = nums.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - 1 - i; j++) {
                nums[j] = nums[j] + nums[j + 1];
            }
        }
        return nums[0];
    }
}
}