public class Solution {

import java.util.*;

public class Solution {
    public int[] minBitwiseArray(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];

        for (int i = 0; i < n; i++) {
            int num = nums[i];
            int minVal = Integer.MAX_VALUE;
            for (int j = 0; j <= num; j++) {
                if ((j | num) == num) {
                    minVal = Math.min(minVal, j);
                }
            }
            result[i] = minVal;
        }

        return result;
    }
}
}