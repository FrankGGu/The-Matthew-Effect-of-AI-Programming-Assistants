public class Solution {

import java.util.Arrays;

public class Solution {
    public int[] absoluteSums(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        int[] prefix = new int[n];

        prefix[0] = nums[0];
        for (int i = 1; i < n; i++) {
            prefix[i] = prefix[i - 1] + nums[i];
        }

        for (int i = 0; i < n; i++) {
            int leftSum = prefix[i] - nums[i];
            int rightSum = prefix[n - 1] - prefix[i];
            result[i] = nums[i] * i - leftSum + rightSum - nums[i] * (n - i - 1);
        }

        return result;
    }
}
}