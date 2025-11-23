public class Solution {

import java.util.*;

public class Solution {
    public int[] getAverages(int[] nums, int k) {
        int n = nums.length;
        int[] result = new int[n - 2 * k];
        if (k == 0) {
            return nums;
        }
        if (n < 2 * k) {
            return new int[0];
        }

        long sum = 0;
        for (int i = 0; i < 2 * k; i++) {
            sum += nums[i];
        }

        for (int i = 0; i < result.length; i++) {
            result[i] = (int) (sum / (2 * k));
            if (i + 2 * k < n) {
                sum += nums[i + 2 * k] - nums[i];
            }
        }

        return result;
    }
}
}