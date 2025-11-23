public class Solution {

import java.util.*;

public class Solution {
    public int maximumSubarraySum(int[] nums) {
        int n = nums.length;
        int maxSum = Integer.MIN_VALUE;
        int[] prefix = new int[n];
        int[] suffix = new int[n];

        prefix[0] = nums[0];
        for (int i = 1; i < n; i++) {
            prefix[i] = Math.max(nums[i], prefix[i - 1] + nums[i]);
        }

        suffix[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            suffix[i] = Math.max(nums[i], suffix[i + 1] + nums[i]);
        }

        for (int i = 0; i < n; i++) {
            int left = (i > 0) ? prefix[i - 1] : 0;
            int right = (i < n - 1) ? suffix[i + 1] : 0;
            maxSum = Math.max(maxSum, left + right);
        }

        return maxSum;
    }
}
}