public class Solution {

import java.util.*;

public class Solution {
    public int minimumSubtractOperations(int[] nums) {
        Arrays.sort(nums);
        int count = 0;
        int last = 0;
        for (int i = nums.length - 1; i >= 0; i--) {
            if (nums[i] != last) {
                count++;
                last = nums[i];
            }
        }
        return count;
    }
}
}