public class Solution {

import java.util.*;

public class Solution {
    public int countNonDecreasingSubarrays(int[] nums) {
        int n = nums.length;
        int result = 0;
        int count = 1;

        for (int i = 1; i < n; i++) {
            if (nums[i] >= nums[i - 1]) {
                count++;
            } else {
                count = 1;
            }
            result += count;
        }

        return result;
    }
}
}