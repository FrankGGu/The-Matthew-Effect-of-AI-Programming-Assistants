public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> maxSumOfThreeSubarrays(int[] nums, int k) {
        int n = nums.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int[] left = new int[n];
        int[] right = new int[n];
        int[] sum = new int[n];

        for (int i = 0; i < n; i++) {
            sum[i] = prefix[i + k] - prefix[i];
        }

        left[0] = 0;
        for (int i = 1; i < n; i++) {
            left[i] = Math.max(left[i - 1], sum[i]);
        }

        right[n - 1] = sum[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            right[i] = Math.max(right[i + 1], sum[i]);
        }

        List<Integer> result = new ArrayList<>();
        int maxSum = 0;

        for (int i = k; i < n - k + 1; i++) {
            int leftMax = left[i - 1];
            int rightMax = right[i + k];
            int currentSum = sum[i] + leftMax + rightMax;

            if (currentSum > maxSum) {
                maxSum = currentSum;
                result.clear();
                result.add(leftIndex(sum, leftMax, i - 1));
                result.add(i);
                result.add(rightIndex(sum, rightMax, i + k));
            }
        }

        return result;
    }

    private int leftIndex(int[] sum, int target, int end) {
        for (int i = end; i >= 0; i--) {
            if (sum[i] == target) {
                return i;
            }
        }
        return 0;
    }

    private int rightIndex(int[] sum, int target, int start) {
        for (int i = start; i < sum.length; i++) {
            if (sum[i] == target) {
                return i;
            }
        }
        return 0;
    }
}
}