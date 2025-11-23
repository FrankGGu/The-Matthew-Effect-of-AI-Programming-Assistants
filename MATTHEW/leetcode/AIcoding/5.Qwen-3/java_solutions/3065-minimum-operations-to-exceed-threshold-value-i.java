public class Solution {

import java.util.*;

public class Solution {
    public int minOperationsToExceedThreshold(int[] nums, int threshold) {
        Arrays.sort(nums);
        int sum = 0;
        int operations = 0;
        for (int num : nums) {
            sum += num;
            operations++;
            if (sum > threshold) {
                return operations;
            }
        }
        return -1;
    }
}
}