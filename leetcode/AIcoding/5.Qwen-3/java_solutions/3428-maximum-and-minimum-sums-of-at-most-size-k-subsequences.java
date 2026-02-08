public class Solution {

import java.util.*;

public class Solution {
    public int[] maxMinSum(int[] nums, int k) {
        int n = nums.length;
        int[] maxSum = new int[n];
        int[] minSum = new int[n];

        Arrays.fill(maxSum, Integer.MIN_VALUE);
        Arrays.fill(minSum, Integer.MAX_VALUE);

        maxSum[0] = nums[0];
        minSum[0] = nums[0];

        for (int i = 1; i < n; i++) {
            maxSum[i] = Math.max(nums[i], maxSum[i - 1] + nums[i]);
            minSum[i] = Math.min(nums[i], minSum[i - 1] + nums[i]);
        }

        int max = Integer.MIN_VALUE;
        int min = Integer.MAX_VALUE;

        for (int i = k - 1; i < n; i++) {
            max = Math.max(max, maxSum[i]);
            min = Math.min(min, minSum[i]);
        }

        return new int[]{max, min};
    }
}
}