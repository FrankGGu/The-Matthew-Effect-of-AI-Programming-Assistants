public class Solution {

import java.util.*;

public class Solution {
    public long maxStrength(int[] nums) {
        if (nums.length == 1) {
            return nums[0];
        }
        Arrays.sort(nums);
        int n = nums.length;
        long maxProduct = Long.MIN_VALUE;
        for (int i = 0; i < n - 1; i++) {
            for (int j = i + 1; j < n; j++) {
                long product = (long) nums[i] * nums[j];
                if (product > maxProduct) {
                    maxProduct = product;
                }
            }
        }
        return maxProduct;
    }
}
}