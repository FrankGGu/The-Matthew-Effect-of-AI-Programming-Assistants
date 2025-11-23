import java.util.Arrays;

class Solution {
    public int minimumSum(int[] nums) {
        int n = nums.length;
        int minSum = Integer.MAX_VALUE;

        for (int i = 1; i < n - 1; i++) {
            int leftMin = Integer.MAX_VALUE;
            for (int j = 0; j < i; j++) {
                if (nums[j] < nums[i]) {
                    leftMin = Math.min(leftMin, nums[j]);
                }
            }

            int rightMin = Integer.MAX_VALUE;
            for (int k = i + 1; k < n; k++) {
                if (nums[k] < nums[i]) {
                    rightMin = Math.min(rightMin, nums[k]);
                }
            }

            if (leftMin != Integer.MAX_VALUE && rightMin != Integer.MAX_VALUE) {
                minSum = Math.min(minSum, leftMin + nums[i] + rightMin);
            }
        }

        return (minSum == Integer.MAX_VALUE) ? -1 : minSum;
    }
}