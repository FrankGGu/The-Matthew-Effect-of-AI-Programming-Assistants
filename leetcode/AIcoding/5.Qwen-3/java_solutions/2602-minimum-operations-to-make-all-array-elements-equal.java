public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums, int k) {
        Arrays.sort(nums);
        int operations = 0;
        for (int i = 0; i < nums.length - 1; i++) {
            if (nums[i] != nums[i + 1]) {
                int diff = nums[i + 1] - nums[i];
                operations += diff / k;
                if (diff % k != 0) {
                    operations++;
                }
            }
        }
        return operations;
    }
}
}