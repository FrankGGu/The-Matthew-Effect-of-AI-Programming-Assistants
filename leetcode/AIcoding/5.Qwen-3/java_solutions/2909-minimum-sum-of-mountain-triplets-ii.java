public class Solution {
    public int minimumSum(int[] nums) {
        int n = nums.length;
        int minSum = Integer.MAX_VALUE;

        for (int i = 1; i < n - 1; i++) {
            int left = 0;
            int right = 0;
            for (int j = 0; j < i; j++) {
                if (nums[j] < nums[i]) {
                    left = nums[j];
                    break;
                }
            }
            for (int j = n - 1; j > i; j--) {
                if (nums[j] < nums[i]) {
                    right = nums[j];
                    break;
                }
            }
            if (left != 0 && right != 0) {
                minSum = Math.min(minSum, left + nums[i] + right);
            }
        }

        return minSum == Integer.MAX_VALUE ? -1 : minSum;
    }
}