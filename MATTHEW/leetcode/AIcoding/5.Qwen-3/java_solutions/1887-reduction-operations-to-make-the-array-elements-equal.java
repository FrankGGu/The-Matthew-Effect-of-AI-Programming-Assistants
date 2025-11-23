public class Solution {

import java.util.*;

public class Solution {
    public int reductionOperations(int[] nums) {
        Arrays.sort(nums);
        int operations = 0;
        int count = 1;
        for (int i = nums.length - 1; i > 0; i--) {
            if (nums[i] != nums[i - 1]) {
                operations += count;
            } else {
                count++;
            }
        }
        return operations;
    }
}
}