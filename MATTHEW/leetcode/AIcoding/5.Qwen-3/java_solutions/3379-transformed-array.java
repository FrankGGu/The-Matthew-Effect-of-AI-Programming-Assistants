public class Solution {

import java.util.Arrays;

public class TransformedArray {
    public int[] transformArray(int[] nums) {
        int n = nums.length;
        int[] result = Arrays.copyOf(nums, n);

        for (int i = 1; i < n - 1; i++) {
            if (nums[i - 1] == nums[i + 1]) {
                result[i] = nums[i - 1] + nums[i + 1];
            }
        }

        return result;
    }
}
}