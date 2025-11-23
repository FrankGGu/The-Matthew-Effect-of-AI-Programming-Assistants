public class Solution {

import java.util.*;

public class Solution {
    public int maxSumTwoNoOverlap(int[] nums, int k) {
        int n = nums.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int maxSum = 0;

        for (int i = 0; i <= n - k; i++) {
            int sum1 = prefix[i + k] - prefix[i];
            int maxSum2 = 0;
            for (int j = 0; j <= i - k; j++) {
                maxSum2 = Math.max(maxSum2, prefix[j + k] - prefix[j]);
            }
            for (int j = i + k; j <= n - k; j++) {
                maxSum2 = Math.max(maxSum2, prefix[j + k] - prefix[j]);
            }
            maxSum = Math.max(maxSum, sum1 + maxSum2);
        }

        return maxSum;
    }
}
}