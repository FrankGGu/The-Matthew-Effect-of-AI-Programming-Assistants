public class Solution {

import java.util.*;

public class Solution {
    public int[] maxAndMinSum(int[] nums, int k) {
        int n = nums.length;
        int[] result = new int[2];
        int maxSum = Integer.MIN_VALUE;
        int minSum = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            int currentSum = 0;
            for (int j = i; j < Math.min(n, i + k); j++) {
                currentSum += nums[j];
                if (j - i + 1 <= k) {
                    maxSum = Math.max(maxSum, currentSum);
                    minSum = Math.min(minSum, currentSum);
                }
            }
        }

        result[0] = maxSum;
        result[1] = minSum;
        return result;
    }
}
}